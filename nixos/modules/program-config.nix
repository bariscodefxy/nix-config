{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.dconf.enable = true;

  # Otomatik offload: masaüstü Intel'de kalır, Steam ve altındaki
  # tüm oyunlar (Proton dahil) Nvidia ile açılır. Oyun başına
  # launch option yazmaya gerek yok.
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __VK_LAYER_NV_optimus = "NVIDIA_only";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
}
