{ config, ... }:
{
  home = {
    username = "baris";
    homeDirectory = "/home/baris";
    enableNixpkgsReleaseCheck = false;
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # Rokit-managed Roblox toolchain: rojo, stylua, selene, wally.
  # NixOS has no ~/.local/bin on PATH by default, so register it explicitly.
  #
  # PATH is a search variable in current Home Manager: `home.sessionPath`
  # populates `home.sessionSearchVariables.PATH`, and entries are prepended in
  # list order. Referencing the old `config.xdg.sessionVariables.PATH` no
  # longer works -- the xdg module is gone and its session variables were
  # folded into `home.sessionVariables` / `home.sessionSearchVariables`.
  home.sessionSearchVariables.PATH = [ "${config.home.homeDirectory}/.rokit/bin" ];

  systemd.user.startServices = "sd-switch";
}
