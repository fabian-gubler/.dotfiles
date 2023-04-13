{
  description = "Python environment with arrow and icalendar modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {};
    packages = {
      python3 = nixpkgs.python3.withPackages (pythonPackages: [
        pythonPackages.arrow
        pythonPackages.icalendar
      ]);
    };
    defaultPackage = self.packages.python3;
  };
}
