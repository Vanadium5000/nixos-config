{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "nixos-wallpapers";
  version = "unstable-2024-12-10";

  src = fetchFromGitHub {
    owner = "nixos";
    repo = "nixos-artwork";
    rev = "63f68a917f4e8586c5d35e050cdaf1309832272d";
    sha256 = "sha256-4be1jsdEGa1ZcYD4EqxD9teMEQ072qLX+7KL7HhZ0bY=";

    sparseCheckout = [
      "wallpapers"
    ];
  };

  buildPhase = ''
    runHook preBuild
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/wallpapers/
    install wallpapers/*.png $out/wallpapers/

    runHook postInstall
  '';

  meta = {
    description = "Nix related wallpapers";
    homepage = "https://github.com/nixos/nixos-artwork";
  };
}
