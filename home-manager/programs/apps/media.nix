{pkgs, ...}: {
  home.packages = with pkgs; [
    playerctl
    obs-studio
    obs-studio-plugins.obs-vkcapture
    mpv
    audacity
    lsp-plugins
    pear-desktop
    # 3D creation suite. Kept here with the other creative tools rather than
    # in nixos/modules/system-packages.nix, which holds CLI/dev tooling.
    blender
  ];
}
