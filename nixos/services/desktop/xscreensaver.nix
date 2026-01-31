{ pkgs, ... }: 
{
  services.xscreensaver.enable = true;
  security.pam.services.xscreensaver.enable = true;
  environment.systemPackages = with pkgs; [
    xscreensaver
  ];
}