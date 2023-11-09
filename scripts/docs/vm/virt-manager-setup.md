# QEMU/KVM Guide

## Fedora Installation:

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
2. Create a new Virtual Machine > Import Existing disk image

## Machine Settings:

1. Add shared filesystem (requires shared memory)
2. Change video driver to virtio
