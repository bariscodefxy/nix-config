{
  inputs,
  pkgs,
  ...
}: let
  mdldec = inputs.mdldec.lib.mdldec pkgs;
in {
  home.packages =
    (with pkgs; [
      lshw
      wget
      btop
      dnsutils
      unrar
      unzip
      nmap
    ])
    ++ [mdldec];
}
