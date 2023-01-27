with import <nixpkgs> { };

let
  pythonPackages = python3Packages;
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  unstable = import unstableTarball { };

  my-python-packages = p: with p; [
    # ...
    (
      buildPythonPackage rec {
        pname = "jupynium";
        version = "0.1.0";
        src = fetchPypi {
          inherit pname version;
          sha256 = "18701f247b96a3b4daccd710834cbf1c6d8218c136df114a0965aea888c02198";
        };
        propagatedBuildInputs = [ setuptools ];
        doCheck = false;
      }
    )
	];

in
pkgs.mkShell rec {
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
    # pythonPackages.numpy
    # pythonPackages.pandas
    # pythonPackages.requests
    # pythonPackages.torch
    # pythonPackages.torchvision
    # pythonPackages.selenium
    unstable.python3Packages.selenium
    python3Packages.versioneer


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
