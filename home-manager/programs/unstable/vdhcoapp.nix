{ pkgs, ... }:
{
    home.packages = with pkgs; [
        vdhcoapp
    ];
}