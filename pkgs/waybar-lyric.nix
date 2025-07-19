{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule (finalAttrs: {
  pname = "waybar-lyric";
  version = "unstable-2025-07-19";

  src = fetchFromGitHub {
    owner = "Nadim147c";
    repo = "waybar-lyric";
    rev = "17f334a46359535ca6775e629e028795598be570";
    hash = "sha256-S0qE4c9xDR9ODriUD1GAfXoByn2n0lbHIpBUugGwd1o=";
  };

  vendorHash = "sha256-DBtSC+ePl6dvHqB10FyeojnYoT3mmsWAnbs/lZLibl8=";

  doInstallCheck = true;

  versionCheckKeepEnvironment = [ "XDG_CACHE_HOME" ];
  preInstallCheck = ''
    # ERROR Failed to find cache directory
    export XDG_CACHE_HOME=$(mktemp -d)
  '';

  meta = {
    description = "Waybar module for displaying song lyrics";
    homepage = "https://github.com/Nadim147c/waybar-lyric";
    license = lib.licenses.agpl3Only;
    mainProgram = "waybar-lyric";
    maintainers = with lib.maintainers; [ vanadium5000 ];
    platforms = lib.platforms.linux;
  };
})
