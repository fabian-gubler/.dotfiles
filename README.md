# Dotfiles for my Linux installation

For more information about Nix and NixOS check out my list of [RESOURCES.md](RESOURCES.md)

## Installation
### Bootstrapping
```bash
sudo nixos-install --flake https://github.com/fabian-gubler/.dotfiles
```

### Customized Build
**Important Note:** `hardware-configuration.nix` file must be customized to your system's hardware. 

The following commands for a fresh system build:

```bash
# Clone the repository
nix-env -iA nixpkgs.git
git clone https://github.com/fabian-gubler/.dotfiles /data/.dotfiles

# Generate hardware-configuration and replace it
sudo nixos-generate config
cd /data/.dotfiles/
cp -f host/hardware-configuration /etc/nixos/hardware-configuration.nix 

# Install NixOS system
sudo nixos-install --flake .#<host>

```
## Helpful tips
### Running Non-Nix binaries
`nix-shell -p steam-run --run "steam-run ./the-binary"`

Check out many possible methods: [Link](https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos)

## Structure
- `host` everything that is system based (e.g. hardware, system packages, window manager)
- `shared` home-manager and .dotfiles for my favorite programs
- `scripts` collection of personal or modified scripts
- `templates` reproducible development environments

## Philosophy: Non Functional Properties
The following are some personal non-functional benefits of using a nix-based system.

### (1) NixOS:
#### Declared Configuration 
- Declared configuration for the entire system. 
- Has to be written once, easily bootstrap anytime

#### Reproducibility
- Reproducible Builds using Lock files
- Easily go back to previous states of entire systems (like timeshift) 

### (2) Nixpkgs & Home-Manager:
#### Vast amount 
- Biggest Offering of Packages (bigger than AUR)
- Fairly well maintained and up to date (otherwise create overlay to make changes)
- Quickly enable / try out packages in an isolated environment

#### Access on Multiple Hosts 
- Reuse on all platforms: Linux, WSL, Darwin based systems
- Create alternative versions of configuration (e.g. server, desktop, laptop)

### (3) Nix Language:
#### Package Management
- Distro-agnostic 
- Nix is straight-forward for building & maintaining personal packages

#### Dev Environments
- Useful for reproducible development environments (with shell.nix)
- Replaces and extends virtual environments (e.g. conda)
- Use for Declarative containers (e.g. docker images)
