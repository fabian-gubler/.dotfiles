# Dotfiles for my Linux installation

## Installation
```bash
sudo nixos-install --flake https://github.com/fabian-gubler/.dotfiles
```

It is important to note that this installation command will not work on every system.
This is due to the `hardware-configuration.nix` file, which must be customized to your system's hardware. 

The following commands can be used for the configuration files to work.

```bash
# Clone the repository
nix-env -iA nixpkgs.git
git clone https://github.com/fabian-gubler/.dotfiles ~/.dotfiles

# Generate hardware-configuration and replace it
sudo nixos-generate config
cd ~/.dotfiles/
cp -f host/hardware-configuration /etc/nixos/hardware-configuration.nix 

# Install NixOS system
sudo nixos-install --flake .#<host>

```
