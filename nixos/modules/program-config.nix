{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  # Darling (MacOBlox) loads the host GL stack with dlopen("libGL.so.1")
  # at runtime; without this there are no EGL configs and every GL
  # context fails. Vendor discovery (nvidia/mesa JSONs, DRI drivers)
  # already resolves through /run/opengl-driver.
  programs.nix-ld.libraries = with pkgs; [ libglvnd ];
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
