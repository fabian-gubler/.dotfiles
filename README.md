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

## Philosophy: Non Functional Properties
The following are some personal non-functional benefits of using a nix-based system.

### NixOS
#### Declared Configuration 
- Declared configuration for the entire system. 
- Has to be written once, easily bootstrap anytime

#### Reproducibility
- Reproducible Builds using Lock files
- Easily go back to previous states of entire systems (like timeshift) 

### Nixpkgs & Home-Manager
#### Vast amount 
- Biggest Offering of Packages (bigger than AUR)
- Fairly good maintained (otherwise overlay to fix)

#### Access on Multiple Hosts 
- Reuse on all platforms: Linux, WSL, Darwin based systems
- Create alternative versions of configuration (e.g. server, desktop, laptop)

### Nix Language
#### Package Management
- Distro-agnostic 
- Nix is great for building & maintaining personal packages

#### Dev Environments
- Useful for reproducible development environments (shell.nix) 
- Declarative docker images
