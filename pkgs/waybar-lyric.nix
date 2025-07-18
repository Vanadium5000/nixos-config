{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "waybar-lyric";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "Nadim147c";
    repo = "waybar-lyric";
    rev = "v${version}";
    sha256 = "sha256-glY0W/fB57pYrAhIxYSnkJBmqeN6vy0cwrS71CnKeK4=";
  };

  # Vendor hash for Go dependencies
  vendorHash = "sha256-DBtSC+ePl6dvHqB10FyeojnYoT3mmsWAnbs/lZLibl8=";

  # Disable tests
  doCheck = false;

  # Metadata for the package
  meta = with lib; {
    description = "A Waybar module for displaying song lyrics";
    homepage = "https://github.com/Nadim147c/waybar-lyric";
    license = licenses.agpl3Only;
    mainProgram = "waybar-lyric";
    maintainers = /* with maintainers; */ [ ];
  };
}