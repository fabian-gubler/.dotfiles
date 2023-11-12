## Bootstrapping

Fastest:
1. Copy qcow2 image
2. Open with virt-manager

Manual: (Use Case: Fresh Install, Different Hypervisor)
1. NixOS Command Line Installer
2. Partitioning
3. hardware.nix?
4. Run nixos-install --flake https://github.com/fabian-gubler/.dotfiles#nixos

Advanced:
- [nixos-anywhere](https://github.com/nix-community/nixos-anywhere)


## Creating Custom ISO / qcow

Create ISO using flake in current directory:

TODO:
- qcow better?
- formats for windows/mac: 
    - virtualbox
    - vmware

```bash
nix run github:nix-community/nixos-generators -- --flake .# \
-f install-iso -I nixpkgs=channel:nixos-22.05
```

```bash
nix run github:nix-community/nixos-generators -- --flake .# \
-f install-iso -I nixpkgs=channel:nixos-22.05 -o /path/to/nixos.qcow2
```

In which:
- 22.05 is the version of NixOS for which the ISO should be build. If -I nixpkgs=channel:nixos-22.05 is ommitted, nixos-unstable will be used.

You now have a custom NixOS installer ISO that can be used to boot into an installer environment with your custom settings and additional packages applied.

---

Post Steps (still to be determined):
- hardware.nix generate?

---

If you want to keep exploring, you can take a look at the [nixos-generator](https://github.com/nix-community/nixos-generators/tree/master) supported formats to generate even more images!
