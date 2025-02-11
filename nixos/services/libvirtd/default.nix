{ pkgs, ... }:
{
  systemd.services.libvirtd = {
    path =
      let
        env = pkgs.buildEnv {
          name = "qemu-hook-env";
          paths = with pkgs; [
            bash
            libvirt
            kmod
            systemd
            ripgrep
            sd
          ];
        };
      in
      [ env ];

    preStart = ''
      mkdir -p /var/lib/libvirt/hooks
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin
      mkdir -p /var/lib/libvirt/hooks/qemu.d/win10/release/end
      mkdir -p /var/lib/libvirt/vgabios

      cp -r ${builtins.toString ../../.}/configs/virt/qemu /var/lib/libvirt/hooks/qemu
      cp -r ${builtins.toString ../../.}/configs/virt/kvm.conf /var/lib/libvirt/hooks/kvm.conf
      cp -r ${builtins.toString ../../.}/configs/virt/start.sh /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
      cp -r ${builtins.toString ../../.}/configs/virt/stop.sh /var/lib/libvirt/hooks/qemu.d/win10/release/end/stop.sh
      cp -r ${builtins.toString ../../.}/configs/virt/patched.rom /var/lib/libvirt/vgabios/patched.rom

      chmod +x /var/lib/libvirt/hooks/qemu
      chmod +x /var/lib/libvirt/hooks/kvm.conf
      chmod +x /var/lib/libvirt/hooks/qemu.d/win10/prepare/begin/start.sh
      chmod +x /var/lib/libvirt/hooks/qemu.d/win10/release/end/stop.sh
      chmod +x /var/lib/libvirt/vgabios/patched.rom

      chown -R qemu-libvirtd:qemu-libvirtd /var/lib/libvirt/images
      chown -R qemu-libvirtd:qemu-libvirtd /var/lib/libvirt/qemu
      chown -R qemu-libvirtd:qemu-libvirtd /var/lib/libvirt/vgabios/patched.rom
    '';
  };
}
