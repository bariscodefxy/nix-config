{
  lib,
  ...
}:
{
  virtualisation.docker.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
    qemu = {
      ovmf.enable = true;
      runAsRoot = false;
    };
  };

  systemd.services."libvirt-guests".wantedBy = lib.mkForce [ ];
}
