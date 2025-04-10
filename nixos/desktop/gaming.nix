{
  pkgs,
  lib,
  config,
  ...
}: {
  # Unfree but specifically allowed in common/nixpkgs.nix
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true; # GameScope driven Steam session
  };

  # Persist steam
  customPersist.home.directories = [".local/share/Steam"];

  programs.gamemode.enable = true; # optimises system performance on demand

  environment.systemPackages =
    (with pkgs; [
      mangohud # overlay program for monitoring FPS, CPU & GPU usage, etc
      lutris # Game launcher
      #bottles # Wineprefix manager
    ])
    # Automattically launch steam in offload-mode
    # https://nixos.wiki/wiki/Nvidia#Automatically_launching_Apps_in_Offload_Mode
    ++ (with pkgs; let
      patchDesktop = pkg: appName: from: to:
        lib.hiPrio (
          pkgs.runCommand "$patched-desktop-entry-for-${appName}" {} ''
            ${coreutils}/bin/mkdir -p $out/share/applications
            ${gnused}/bin/sed 's#${from}#${to}#g' < ${pkg}/share/applications/${appName}.desktop > $out/share/applications/${appName}.desktop
          ''
        );
      GPUOffloadApp = pkg: desktopName:
        lib.mkIf config.hardware.nvidia.prime.offload.enable
        (patchDesktop pkg desktopName "^Exec=" "Exec=nvidia-offload ");
    in [(GPUOffloadApp steam "steam")]);
}
