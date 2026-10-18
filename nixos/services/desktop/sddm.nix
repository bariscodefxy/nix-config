{ ... }:
{
  # Both desktop variants (niri and plasma6's kwin_wayland session) are
  # Wayland-only, so there is no X server to host an X11 greeter. SDDM
  # asserts that one of the two must be present, hence the Wayland greeter
  # (weston, the module default) instead of `services.xserver.enable`.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
}
