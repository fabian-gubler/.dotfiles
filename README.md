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

## Non Functional Properties
### NixOS
- Declared Configuration (Write once)
- Reproducible Builds (Reliability & Stability)

### Nixpkgs & Home-Manager
- Biggest Offering of Packages
- Access on Multiple Hosts (works on Linux, WSL, Darwin based systems)

### Nix Language
- Great for building & maintaining personal, distro-agnostic packages
- Useful for reproducible development environments (shell.nix) & declarative docker images
