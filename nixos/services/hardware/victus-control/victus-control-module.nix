{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.victus-control;
  pkg = pkgs.victus-control;
  fcfg = cfg.fanCurve;

  fanCurveScript = pkgs.writeShellScript "victus-fan-curve" ''
    set -u
    HWMON_BASE="/sys/devices/platform/hp-wmi/hwmon"
    STATE_FILE="/run/victus-control/fan-curve-state"
    HIGH=${toString fcfg.highTemp}
    LOW=${toString fcfg.lowTemp}
    MINPWM=${toString fcfg.minPwm}
    INTERVAL=${toString fcfg.pollInterval}
    SETTLE=${toString fcfg.settleTime}
    USE_GPU=${if fcfg.useGpu then "1" else "0"}

    # En yüksek numaralı hwmon dizini (backend ile aynı seçim).
    find_hwmon() {
      find "$HWMON_BASE" -mindepth 1 -maxdepth 1 -type d -name 'hwmon*' 2>/dev/null \
        | sort -V | tail -n 1
    }

    # CPU sıcaklığı: coretemp sensörlerinin maksimumu (miliderece -> derece).
    cpu_temp() {
      local max=0 t f
      for f in /sys/class/hwmon/hwmon*/temp*_input; do
        [ -e "$f" ] || continue
        [ "$(cat "''${f%/temp*_input}/name" 2>/dev/null)" = "coretemp" ] || continue
        t=$(cat "$f" 2>/dev/null) || continue
        t=$((t / 1000))
        [ "$t" -gt "$max" ] && max=$t
      done
      if [ "$max" -eq 0 ]; then
        for f in /sys/class/thermal/thermal_zone*/temp; do
          [ -e "$f" ] || continue
          t=$(cat "$f" 2>/dev/null) || continue
          t=$((t / 1000))
          [ "$t" -gt "$max" ] && max=$t
        done
      fi
      echo "$max"
    }

    gpu_temp() {
      if [ "$USE_GPU" != "1" ]; then
        echo 0
        return 0
      fi
      local out
      out=$(timeout 3 nvidia-smi --query-gpu=temperature.gpu \
        --format=csv,noheader,nounits 2>/dev/null | head -n 1) || out=""
      out=$(echo "$out" | tr -cd '0-9')
      [ -n "$out" ] && echo "$out" || echo 0
    }

    save_state() {
      echo "$last_mode $last_pwm $changed_at $ema" > "$STATE_FILE" 2>/dev/null || true
    }

    # Uygulanan soğutma seviyesi: AUTO=0, MANUAL=pwm(1-255), MAX=300.
    applied_level() {
      if [ "$last_mode" = "0" ]; then echo 300
      elif [ "$last_mode" = "1" ]; then echo "$last_pwm"
      else echo 0
      fi
    }

    last_mode="2"
    last_pwm="0"
    changed_at=0
    ema=0
    if [ -f "$STATE_FILE" ]; then
      read -r last_mode last_pwm changed_at ema < "$STATE_FILE" 2>/dev/null || true
      [ -z "$last_mode" ] && last_mode="2"
      [ -z "$last_pwm" ] && last_pwm="0"
      [ -z "$changed_at" ] && changed_at=0
      [ -z "$ema" ] && ema=0
    fi

    while true; do
      hwmon=$(find_hwmon)
      if [ -z "$hwmon" ] || [ ! -e "$hwmon/pwm1_enable" ]; then
        sleep "$INTERVAL"
        continue
      fi

      cpu=$(cpu_temp)
      gpu=$(gpu_temp)
      temp=$cpu
      [ "$gpu" -gt "$temp" ] && temp=$gpu
      # Sensör okunamazsa mevcut durumu koru (sıcakken fanı kısmak yok).
      if [ "$temp" -le 0 ]; then
        sleep "$INTERVAL"
        continue
      fi

      cur_enable=$(cat "$hwmon/pwm1_enable" 2>/dev/null | tr -cd '0-9')
      cur_pwm1=$(cat "$hwmon/pwm1" 2>/dev/null | tr -cd '0-9')
      [ -z "$cur_pwm1" ] && cur_pwm1="0"
      now=$(date +%s)

      # Sahiplik: enable bizim son yazdığımızdan farklıysa kullanıcı veya
      # backend değiştirmiş demektir; harici MAX'a saygı duy (geri çekil),
      # diğer durumlarda yönetimi devral.
      if [ "$cur_enable" != "$last_mode" ]; then
        last_mode=$cur_enable
        last_pwm=$cur_pwm1
        changed_at=$now
        save_state
        if [ "$last_mode" = "0" ]; then
          sleep "$INTERVAL"
          continue
        fi
      fi

      # Sinyal yumuşatma: paket sıcaklığı ani yükte saniyeler içinde 20-30C
      # sıçrar; ham değere göre karar vermek fanı sürekli MAX'e vurur.
      # Üstel hareketli ortalama ile yumuşat, kritik eşikte ham değere bak.
      if [ "$ema" -le 0 ]; then
        ema=$temp
      else
        ema=$(((temp + ema * 3) / 4))
      fi
      stemp=$ema
      [ "$temp" -ge "${toString fcfg.criticalTemp}" ] && stemp=$temp

      # Hedef her zaman MANUAL: LOW altı minPwm, HIGH üstü 255,
      # arası doğrusal eğri. AUTO/MAX'a geçilmez.
      if [ "$stemp" -ge "$HIGH" ]; then
        d_pwm=255
      elif [ "$stemp" -le "$LOW" ]; then
        d_pwm=$MINPWM
      else
        d_pwm=$((MINPWM + (stemp - LOW) * (255 - MINPWM) / (HIGH - LOW)))
      fi
      [ "$d_pwm" -gt 255 ] && d_pwm=255
      [ "$d_pwm" -lt 1 ] && d_pwm=1
      d_mode="1"
      d_level=$d_pwm
      a_level=$(applied_level)

      apply=0
      if [ "$d_level" -gt "$a_level" ]; then
        apply=1 # soğutmayı artırmak her zaman serbest
      elif [ "$d_level" -lt "$a_level" ] && [ $((now - changed_at)) -ge "$SETTLE" ]; then
        apply=1 # kısma yönünde yerleşme süresi dolduysa serbest
      fi

      if [ "$apply" = "1" ]; then
        ok=1
        if [ "$d_mode" != "$last_mode" ]; then
          echo "$d_mode" > "$hwmon/pwm1_enable" 2>/dev/null || ok=0
        fi
        if [ "$ok" = "1" ] && [ "$d_mode" = "1" ]; then
          echo "$d_pwm" > "$hwmon/pwm1" 2>/dev/null || ok=0
          echo "$d_pwm" > "$hwmon/pwm2" 2>/dev/null || ok=0
        fi
        if [ "$ok" = "1" ]; then
          last_mode=$d_mode
          last_pwm=$d_pwm
          changed_at=$now
          save_state
          echo "fan-curve: raw=''${temp}C ema=''${stemp}C -> mode=$d_mode pwm=$d_pwm" >&2
        fi
      fi

      sleep "$INTERVAL"
    done
  '';
in
{
  options.services.victus-control = {
    enable = lib.mkEnableOption "Victus Control backend service";

    fanCurve = {
      enable = lib.mkEnableOption "userspace temperature curve in MANUAL pwm mode for boards whose EC fan curve is broken";

      highTemp = lib.mkOption {
        type = lib.types.int;
        default = 80;
        description = "Full PWM (255) at or above this CPU/GPU temperature (°C).";
      };

      lowTemp = lib.mkOption {
        type = lib.types.int;
        default = 65;
        description = "Minimum PWM at or below this temperature (°C). Must be below highTemp.";
      };

      minPwm = lib.mkOption {
        type = lib.types.int;
        default = 80;
        description = "PWM value (0-255) applied at the low end of the MANUAL range.";
      };

      pollInterval = lib.mkOption {
        type = lib.types.int;
        default = 5;
        description = "Temperature poll interval in seconds.";
      };

      settleTime = lib.mkOption {
        type = lib.types.int;
        default = 60;
        description = "Minimum seconds between cooling decreases (prevents fan flapping). Increases apply immediately.";
      };

      criticalTemp = lib.mkOption {
        type = lib.types.int;
        default = 95;
        description = "Raw temperature (°C) that forces full PWM immediately, bypassing signal smoothing.";
      };

      useGpu = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Include NVIDIA GPU temperature (wakes the dGPU to query).";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !fcfg.enable || fcfg.lowTemp < fcfg.highTemp;
        message = "services.victus-control.fanCurve.lowTemp must be below highTemp.";
      }
    ];

    environment.systemPackages = [ pkg ];

    users.groups.victus = { };
    users.groups.victus-backend = { };
    users.users.victus-backend = {
      isSystemUser = true;
      group = "victus-backend";
      extraGroups = [ "victus" ];
      description = "Victus Control backend service user";
    };

    services.udev.packages = [ pkg ];

    # Upstream'in leds kuralları GROUP=/MODE= kullanıyor ama bunlar sysfs
    # özniteliklerine işlemez (sadece /dev düğümlerine). Backend tek-bölge
    # klavyeyi doğrudan yazdığı için brightness/multi_intensity dosyalarının
    # victus grubuna yazılabilir olması gerekir; hwmon kuralındaki çalışan
    # RUN+ kalıbının aynısı burada da kullanılır.
    services.udev.extraRules = ''
      SUBSYSTEM=="leds", KERNELS=="hp::kbd_backlight", ACTION=="add|change", RUN+="/bin/sh -c 'chgrp victus /sys%p/brightness /sys%p/multi_intensity 2>/dev/null; chmod g+w /sys%p/brightness /sys%p/multi_intensity 2>/dev/null'"
      SUBSYSTEM=="hwmon", KERNELS=="hp-wmi", ACTION=="add|change", RUN+="/bin/sh -c 'chgrp victus /sys%p/pwm1 /sys%p/pwm2 2>/dev/null; chmod g+w /sys%p/pwm1 /sys%p/pwm2 2>/dev/null'"
    '';

    systemd.tmpfiles.rules = [
      "d /run/victus-control 0770 victus-backend victus - -"
    ];

    security.sudo.extraRules = [
      {
        users = [ "victus-backend" ];
        commands = map (h: {
          command = "${pkg}/bin/${h}";
          options = [ "NOPASSWD" ];
        }) [
          "set-fan-speed.sh"
          "set-fan-mode.sh"
          "set-rgb-zone.sh"
          "set-rgb-zones.sh"
        ];
      }
    ];

    systemd.services.victus-healthcheck = {
      description = "Victus Control kernel module health check";
      wantedBy = [ "multi-user.target" ];
      before = [ "victus-backend.service" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkg}/lib/victus-control/victus-healthcheck.sh";
        RemainAfterExit = true;
      };
    };

    systemd.services.victus-fan-curve = lib.mkIf fcfg.enable {
      description = "Victus Control temperature curve (MANUAL pwm) for broken EC fan curves";
      wantedBy = [ "multi-user.target" ];
      after = [
        "victus-backend.service"
        "systemd-udev-settle.service"
      ];
      # NOT: RuntimeDirectory=victus-control buraya KONMAZ. Bu dizin
      # victus-backend'e aittir ve soketi içinde yaşar; ikinci bir servis
      # aynı RuntimeDirectory'yi alırsa systemd stop sırasında dizini silip
      # backend soketini yok eder ("No Server connection").
      serviceConfig = {
        Type = "simple";
        ExecStart = "${fanCurveScript}";
        ExecStopPost = "${pkgs.bash}/bin/bash -c 'H=$(ls -d /sys/devices/platform/hp-wmi/hwmon/hwmon* 2>/dev/null | sort -V | tail -n 1); [ -n \"$H\" ] && echo 2 > \"$H/pwm1_enable\" 2>/dev/null || true'";
        Restart = "always";
        RestartSec = 5;
        User = "victus-backend";
        Group = "victus";
        Environment = "PATH=${
          lib.makeBinPath [
            pkgs.coreutils
            pkgs.findutils
            pkgs.gawk
          ]
        }:/run/opengl-driver/bin:/run/current-system/sw/bin";
      };
    };

    systemd.services.victus-backend = {
      description = "Victus Control Backend Service";
      wantedBy = [ "multi-user.target" ];
      after = [
        "network.target"
        "victus-healthcheck.service"
        "systemd-udev-settle.service"
      ];
      wants = [ "victus-healthcheck.service" ];
      conflicts = [ "victus-fan.service" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkg}/bin/victus-backend";
        Restart = "always";
        RestartSec = 5;
        User = "victus-backend";
        Group = "victus";
        StateDirectory = "victus-control";
        RuntimeDirectory = "victus-control";
        RuntimeDirectoryMode = "0770";
      };
    };
  };
}
