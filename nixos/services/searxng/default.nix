{ ... }:
{
  services.searx = {
    enable = true;
    redisCreateLocally = true;
    settings.server = {
      bind_address = "127.0.0.1";
      port = 3080;
      # WARNING: setting secret_key here might expose it to the nix cache
      # see below for the sops or environment file instructions to prevent this
      secret_key = "Your secret key.";
    };
  };
}
