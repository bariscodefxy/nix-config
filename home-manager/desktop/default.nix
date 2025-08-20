{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    (pkgs.whitesur-kde.overrideAttrs (old: {
      installPhase = ''
        runHook preInstall

        mkdir -p $out/doc
        name= ./install.sh -w opaque

        mkdir -p $out/share/sddm/themes
        sddm/install.sh -w opaque

        runHook postInstall
      '';
    }))
    whitesur-icon-theme
    whitesur-cursors
  ];

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/WhiteSur-opaque".source =
      "${pkgs.whitesur-kde.overrideAttrs (old: {
        installPhase = ''
          runHook preInstall
          mkdir -p $out/doc
          name= ./install.sh -w opaque
          mkdir -p $out/share/sddm/themes
          sddm/install.sh -w opaque
          runHook postInstall
        '';
      })}/share/Kvantum/WhiteSur-opaque";
    "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=WhiteSur";
  };
}
