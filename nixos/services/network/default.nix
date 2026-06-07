{ ... }:
{
  imports = [
    ./openssh.nix
    ./squid.nix
    ./mullvad.nix
    ./avahi.nix
    ./dnsmasq.nix
  ];
}
