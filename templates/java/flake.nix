{
  description = "A Nix-flake-based Java development environment";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs =
    { self
    , flake-utils
    , nixpkgs
    }:

    flake-utils.lib.eachDefaultSystem (system:
    let
      javaVersion = 17;

      overlays = [
        (self: super: rec {
          jdk = super."jdk${toString javaVersion}";
          gradle = super.gradle.override {
            java = jdk;
          };
          maven = super.maven.override {
            inherit jdk;
          };
        })
      ];

      pkgs = import nixpkgs { inherit overlays system; };
    in
    {
      devShells.default = pkgs.mkShell {
        name = "java";
        buildInputs = with pkgs; [
          gradle
          # jdt-language-server
          jdk
          maven
          google-java-format
        ];

        shellHook = ''
          ${pkgs.jdk}/bin/java -version
        '';
      };
    });
}
