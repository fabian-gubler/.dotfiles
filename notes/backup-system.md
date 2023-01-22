# Backup Strategy
## TODO
- Purchase external HDD
- Setup Borg Backup script (e.g. systemd timer)

Bonus
- Automation: Export of VM Appliances
- Reliability: e.g. Mail if script failure

## Important Files (Cloud)
| Data type                         | Storage                   |
| ---                               | ---                       |
| Media, Personal, Application Data | Host + Nextcloud          |
| Code Repositories & Configuration | Host + Github             |
| VM                                | Host + Nextcloud (Latest) |

## Regular Files 
| Data type     | Storage                          |
| ---           | ---                              |
| OS Recovery   | NixOS (generations)              |
| Data Recovery | Borg Backup (data deduplication) |

Note: Set reasonable NixOS limit (e.g. 7d)

## Borg Setup
[Borg - Arch Wiki](https://wiki.archlinux.org/title/Borg_backup)
**Start**
- `init` to initialize repository

**Automate**
- `create` to backup using custom params (pref. automated)
- `prune` to remove old archives (pref. automated)

**Recover**
- `extract` or `mount` to restore files

## Alternative: Personal Server
Get a rasberry pi for scheduled backups (i.e. data recovery)

Contra
- Time-consuming setup
- Higher Fixed Costs
- Not minimalistic

Pro
+ Media Library w/ Jellyfin, Security w/ PiHole
+ Remote Access
+ Learning Experience
+ Reusability
