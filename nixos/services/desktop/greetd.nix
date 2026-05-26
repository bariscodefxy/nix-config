{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "bariscodefx";
      };
    };
  };
}
