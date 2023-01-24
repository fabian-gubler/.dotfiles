# Dotfiles for my Linux installation

## Installation
### Bootstrapping
```bash
sudo nixos-install --flake https://github.com/fabian-gubler/.dotfiles
```

### Customized Build
**Important Note:** `hardware-configuration.nix` file must be customized to your system's hardware. 

The following commands for a fresh system install:

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

## Structure
- `host` everything that is system based (e.g. hardware, system packages, window manager)
- `modules` home-manager and .dotfiles for my favorite programs
- `scripts` collection of personal or modified scripts

## Philosophy: Non Functional Properties
The following are some personal non-functional benefits of using a nix-based system.

### NixOS:
#### Declared Configuration 
- Declared configuration for the entire system. 
- Has to be written once, easily bootstrap anytime

#### Reproducibility
- Reproducible Builds using Lock files
- Easily go back to previous states of entire systems (like timeshift) 

### Nixpkgs & Home-Manager:
#### Vast amount 
- Biggest Offering of Packages (bigger than AUR)
- Fairly good maintained (otherwise overlay to fix)

#### Access on Multiple Hosts 
- Reuse on all platforms: Linux, WSL, Darwin based systems
- Create alternative versions of configuration (e.g. server, desktop, laptop)

### Nix Language:
#### Package Management
- Distro-agnostic 
- Nix is great for building & maintaining personal packages

#### Dev Environments
- Useful for reproducible development environments (shell.nix) 
- Declarative docker images
