{ pkgs, inputs, ... }:
{
  home.sessionVariables = {
    LAUNCHER = "${inputs.vicinae.packages."${pkgs.system}".default}/bin/vicinae";
    BROWSER = "${inputs.zen-browser.packages."${pkgs.system}".default}/bin/zen";
    TERMINAL = "${pkgs.alacritty}/bin/alacritty";
    FILE_MANAGER = "${pkgs.nautilus}/bin/nautilus";

    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    NIXOS_OZONE_WL = "1";
  };
}
