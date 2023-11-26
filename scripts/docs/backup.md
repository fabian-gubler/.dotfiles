# Backup Notes

## General State

Fedora
- System State is not modified a lot

NixOS
- NixOS System files are automatically backed up with Generations

## Solutions required

**Timeshift**

Allows to easily roll back to previous states, allows to

1. Backup Fedora System
2. Backup Files in /data and home directory
    - Files are stored in nextcloud, github repos
    - Hosting.de -> Files backed up for the last 5 days.
    - However relevant for nextcloud: a) Accidentaly Deleted or b) Revert changes to a file

Configuration:
- Include /home/fabian
- Exclude /nix/ (to make it work, might need to ensure it is at the bottom, below /root)
    ? Will be ignored in future, is listed in root but not in snapshot directly
    - Reason: Save storage, Can be easily reproduced
- Include /data/ 
    ? Does this add it to the files?

**Virtual Machines**
- Physical: Stored in: /var/lib/libvirt/images
- Virtual: Create Snapshot (open -> view -> create)
