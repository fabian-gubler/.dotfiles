# Python
[Read this first](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md#how-to-consume-python-modules-using-pip-in-a-virtual-environment-like-i-am-used-to-on-other-operating-systems)

## Benefits
- Create isolated and temporary python environments
- Environments expose selected dependencies and can re-use actual modules (no duplicate installations)


## Nix-Shells
Philosphically, shells should be familiar to users who are used to a venv style of development: individual projects create their own Python environments without impacting the global environment or each other.

## Ad-hoc Python Environments
The simplest way to start playing with the way nix wraps and sets up Python environments is with nix-shell at the cmdline. These environments create a temporary shell session with a Python and a precise list of packages (plus their runtime dependencies), with no other Python packages in the Python interpreter's scope.

To create a Python 3.9 session with numpy and toolz available, run:
```bash
nix-shell -p 'python39.withPackages(ps: with ps; [ numpy toolz ])'
```

nix-shell can also load an expression from a .nix file. Say we want to have Python 3.9, numpy and toolz, like before, in an environment. We can add a shell.nix file describing our dependencies:

```nix
with import <nixpkgs> {};
(python39.withPackages (ps: [ps.numpy ps.toolz])).env
```

And then at the command line, just typing nix-shell produces the same environment as before.

## Unified Environments
Combining this with mkShell you can:

```nix
with import <nixpkgs> {};
let
  pythonEnv = python39.withPackages (ps: [
    ps.numpy
    ps.toolz
  ]);
in mkShell {
  packages = [
    pythonEnv

    black
    mypy

    libffi
    openssl
  ];
}
```

This will create a unified environment that has not just our Python interpreter and its Python dependencies, but also tools like black or mypy and libraries like libffi the openssl in scope.

## Impure Python Environments
This is an example of a default.nix for a nix-shell, which allows to consume a virtual environment created by venv, and install Python modules through pip the traditional way.

```nix
with import <nixpkgs> { };

let
  pythonPackages = python3Packages;
in pkgs.mkShell rec {
  name = "impurePythonEnv";
  venvDir = "./.venv";
  buildInputs = [
    # A Python interpreter including the 'venv' module is required to bootstrap
    # the environment.
    pythonPackages.python

    # This executes some shell code to initialize a venv in $venvDir before
    # dropping into the shell
    pythonPackages.venvShellHook

    # Those are dependencies that we would like to use from nixpkgs, which will
    # add them to PYTHONPATH and thus make them accessible from within the venv.
    pythonPackages.numpy
    pythonPackages.requests

    # In this particular example, in order to compile any binary extensions they may
    # require, the Python modules listed in the hypothetical requirements.txt need
    # the following packages to be installed locally:
    taglib
    openssl
    git
    libxml2
    libxslt
    libzip
    zlib
  ];

  # Run this command, only after creating the virtual environment
  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -r requirements.txt
  '';

  # Now we can execute any commands within the virtual environment.
  # This is optional and can be left out to run pip manually.
  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH
  '';
}
```



## Resources

## Tooling
- Native Packages
- Poetry2Nix (Poetry Projects)
- Mach-Nix (Not in nixpkgs)
- Build your own Linux Filesystem (Isolation)
