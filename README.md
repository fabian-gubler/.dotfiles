# NixOS Configuration

WORK IN PROGRESS: Currently experimenting running NixOS in a virtual machine

## Installation

```bash
# Clone this repository
git clone https://github.com/fabian-gubler/nixos-config

# Clone Dotfiles
git clone https://github.com/fabian-gubler/.dotfiles ~/.dotfiles

# Symlink configuration.nix
rm /etc/nixos/configuration.nix
sudo ln -s ~/nixos-config/configuration.nix /etc/nixos/configuration.nix

# Build system
sudo nixos-rebuild switch

# Dotfiles Configuration
bash config/configure.sh

# Clone Neovim Configuration
git clone https://github.com/fabian-gubler/nvim-config ~/.config/nvim

# Reboot system
systemctl reboot

```
