# Python
[Excellent Introduction of Ecosystem](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md#how-to-consume-python-modules-using-pip-in-a-virtual-environment-like-i-am-used-to-on-other-operating-systems)

Philosphically, shells should be familiar to users who are used to a venv style of development: individual projects create their own Python environments without impacting the global environment or each other.

## Ad-hoc Python Environments
The simplest way to start playing with the way nix wraps and sets up Python environments is with nix-shell at the cmdline. These environments create a temporary shell session with a Python and a precise list of packages (plus their runtime dependencies), with no other Python packages in the Python interpreter's scope.

To create a Python 3.9 session with numpy and toolz available, run:
```bash
nix-shell -p 'python39.withPackages(ps: with ps; [ numpy toolz ])'
```

## Resources

## Tooling
- Native Packages
- Poetry2Nix (Poetry Projects)
- Mach-Nix (Not in nixpkgs)
- Build your own Linux Filesystem (Isolation)
