{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  # Darling (MacOBlox) loads the host GL stack with dlopen("libEGL.so.1")
  # at runtime; without this there are no EGL configs and every GL
  # context fails. Vendor discovery (nvidia/mesa JSONs, DRI drivers)
  # already resolves through /run/opengl-driver.
  # Minecraft 26.x gömülü SDL3'ü Wayland backend'i dlopen ile açar
  # (libwayland-client, libdecor, libxkbcommon...). Bunlar yoksa
  # SDL_VIDEO_DRIVER=wayland "wayland not available" diye patlar,
  # X11'e düşünce de xwayland-satellite'ta relative mouse çalışmaz.
  programs.nix-ld.libraries = with pkgs; [
    libglvnd
    wayland
    libdecor
    libxkbcommon
    egl-wayland
  ];
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
