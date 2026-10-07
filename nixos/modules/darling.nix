# Darling (macOS translation layer) for MacOBlox.
#
# The raw binary refuses to run without setuid root (it needs mount and PID
# namespaces), exactly like on other distros. NixOS provides that via a
# wrapper; plain `darling` on PATH then resolves to /run/wrappers/bin/darling.
# The unshare-based darling-wrapped script is single-session only (a second
# client cannot join the first session's namespaces) and cannot serve the
# launcher, which spawns `darling shell` repeatedly.
{ inputs, pkgs, ... }:
{
  security.wrappers.darling = {
    source = "${inputs.darling-nix.packages.${pkgs.system}.darling}/bin/darling";
    owner = "root";
    group = "root";
    setuid = true;
  };
}
