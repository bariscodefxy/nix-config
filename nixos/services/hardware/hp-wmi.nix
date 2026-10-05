{
  config,
  lib,
  ...
}:

let
  cfg = config.hardware.hp-wmi-control;
in
{
  options.hardware.hp-wmi-control = {
    enable = lib.mkEnableOption "patched hp-wmi kernel module (manual fan control and zoned keyboard RGB for HP Omen/Victus)";
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [
      (config.boot.kernelPackages.callPackage ../../../pkgs/hp-wmi-fan-control.nix { })
    ];
  };
}
