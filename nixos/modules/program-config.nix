{ pkgs, ... }:
{
  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  # Darling (MacOBlox) loads the host GL stack with dlopen("libEGL.so.1")
  # at runtime; without this there are no EGL configs and every GL
  # context fails. Vendor discovery (nvidia/mesa JSONs, DRI drivers)
  # already resolves through /run/opengl-driver.
  # Minecraft 26.x dlopens embedded SDL3's Wayland backend
  # (libwayland-client, libdecor, libxkbcommon...). Without these,
  # SDL_VIDEO_DRIVER=wayland fails with "wayland not available",
  # and falling back to X11 breaks relative mouse in xwayland-satellite.
  programs.nix-ld.libraries = with pkgs; [
    libglvnd
    wayland
    libdecor
    libxkbcommon
    egl-wayland
  ];
  programs.dconf.enable = true;

  # Automatic offload: desktop stays on Intel, Steam and all games
  # underneath (including Proton) launch on Nvidia. No per-game launch options needed.
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
