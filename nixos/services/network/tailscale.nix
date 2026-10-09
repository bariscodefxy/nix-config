{ ... }:
{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    openFirewall = true;
  };

  # Tailnet'ten gelen trafiğe güven (firewall aktif).
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
