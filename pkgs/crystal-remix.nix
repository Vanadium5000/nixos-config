{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  xdg-utils,
}:
let
  pname = "crystal-remix-icon-theme";
  version = "2.6";
in
stdenvNoCC.mkDerivation {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "dangvd";
    repo = "crystal-remix-icon-theme";
    rev = "v${version}";
    hash = "sha256-t7ATjba9hS4LwWCaD9fvHi1xMjoYEML9buiki3tEcSQ=";
  };

  nativeBuildInputs = [
    gtk3
    xdg-utils
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/Crystal-Remix
    cp -a * $out/share/icons/Crystal-Remix/

    install -d $out/share/icons/Crystal-Remix
    cp -r . $out/share/icons/Crystal-Remix
    gtk-update-icon-cache -f -t $out/share/icons/Crystal-Remix && xdg-desktop-menu forceupdate

    runHook postInstall
  '';

  meta = with lib; {
    description = "A Crystal icon theme for modern Linux desktop environments";
    homepage = "https://github.com/dangvd/crystal-remix-icon-theme";
    platforms = platforms.linux;
    license = licenses.gpl3Only;
    maintainers = [ ];
  };
}
