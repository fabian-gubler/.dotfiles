# QEMU/KVM Guide

## Installation:

**NixOS:**

Declared in virtualization.nix

**Fedora:**

https://docs.fedoraproject.org/en-US/quick-docs/virtualization-getting-started

```bash

# Install relevant packages
sudo dnf install @virtualization

# Start the libvirtd service
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# Verify that kvm kernel modules are loaded (require kvm_intel or kvm_amd)
lsmod | grep kvm

```

## Create Connection

1. File > Add Connection > Qemu (w/ Autoload)
2. Create a new Virtual Machine 
    - a) Import Existing disk image
    - b) Select Installation ISO

## Additional Machine Settings:

1. Add shared filesystem (requires shared memory)
2. Change video driver to virtio
    -> Now QXL with vgamem="16384" (for 4k displays)
