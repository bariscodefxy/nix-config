#!/run/current-system/sw/bin/bash

# Debugging
# exec 19>/home/owner/Desktop/startlogfile
# BASH_XTRACEFD=19
# set -x

# Load variables we defined
source "/var/lib/libvirt/hooks/kvm.conf"

# Isolate host to core 0
systemctl set-property --runtime -- user.slice AllowedCPUs=0
systemctl set-property --runtime -- system.slice AllowedCPUs=0
systemctl set-property --runtime -- init.scope AllowedCPUs=0

# Stop display manager
systemctl stop display-manager.service

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind EFI Framebuffer
echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoid race condition
sleep 2

# Unload NVIDIA kernel modules
modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

# Detach GPU devices from host
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

# Load vfio module
modprobe vfio-pci