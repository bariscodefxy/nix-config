{ desktop, ... }:
{
  imports = [
    ./common.nix
  ]
  ++ (
    if desktop == "plasma" then
      [ ./plasma.nix ]
    else
      [ ./niri.nix ]
  );
}
