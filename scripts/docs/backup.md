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
