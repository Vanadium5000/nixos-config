{
  stdenvNoCC,
  fetchFromGitHub,
  ...
}:
stdenvNoCC.mkDerivation {
  pname = "nixy-wallpapers";
  version = "unstable-2024-12-10";

  src = fetchFromGitHub {
    owner = "anotherhadi";
    repo = "nixy-wallpapers";
    rev = "713754b59d42225588b3818defe7ed05238c83af";
    sha256 = "sha256-Uc3YRAa2oEnvr9v83EctAWpoZlCnrp74Z73h70Nod5E=";

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
    description = "A collection of wallpapers for Nixy";
    homepage = "https://github.com/anotherhadi/nixy-wallpapers";
  };
}
