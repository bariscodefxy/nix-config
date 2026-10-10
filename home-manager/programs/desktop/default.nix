{ desktop, ... }:
{
  imports = [
    ./cursor.nix
    ./gtk.nix
  ]
  ++ (
    if desktop == "plasma" then
      [ ./plasma.nix ]
    else
      [
        ./niri.nix
        ./quickshell.nix
        ./session.nix
      ]
  );
}
