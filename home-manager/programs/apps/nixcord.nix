{ inputs, ... }:
{
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    vesktop.enable = true;
    discord.silenceNoModClientWarning = true;
  };
}
