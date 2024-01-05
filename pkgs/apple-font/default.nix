# Font Repo: https://github.com/epk/SF-Mono-Nerd-Font

# 1. Define Overlay to import all pkgs  `additions = final: _prev: import ../pkgs { pkgs = final; };`
# 2. Add overlay to config  `nixpkgs = { overlays = [ outputs.overlays.additions ]; };`
# 3. Pkg can then be called within `font.packages` in your configuration.nix

{
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "apple-font";
  version = "v18.0d1e1.0";

  src = fetchzip {
    url = "https://github.com/epk/SF-Mono-Nerd-Font/archive/refs/tags/${version}.zip";
    sha256 = "sha256-f5A/vTKCUxdMhCqv0/ikF46tRrx5yZfIkvfExb3/XEQ=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/apple
    mv *.otf $out/share/fonts/apple
    runHook postInstall
  '';
}

