{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./chromium

    ./audio.nix
    ./bluetooth.nix
    ./deploy-vps.nix
    ./flatpak.nix
    ./fonts.nix
    ./gaming.nix
    ./hyprland.nix
    ./nix-ld.nix
    ./ollama.nix
    ./packages.nix
    ./stylix.nix
    ./tuigreet.nix
    ./virtualisation.nix
    #./ydotool.nix
  ];

  home-manager = lib.mkForce {
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${config.var.username} = import ../../home-manager/desktop;
  };

  services = {
    # Battery tool, required by hyprpanel
    upower.enable = true;

    # Enable CUPS printing service
    printing.enable = true;

    # GNOME virtual filesystem
    gvfs.enable = true;

    # DBus service that allows applications to query and manipulate storage devices
    udisks2.enable = true;

    gnome = {
      sushi.enable = true; # Sushi, a quick previewer for nautilus
      evolution-data-server.enable = true; # A collection of services for storing addressbooks and calendars
      gnome-keyring.enable = true; # GNOME Keyring daemon
      gnome-online-accounts.enable = true; # GNOME Online Accounts daemon
    };
  };

  # NetworkManager control applet for desktop
  programs.nm-applet.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    libsecret # Required by Chromium and VSCodium for storing secrets
  ];

  # GUI password prompt for SUDO
  environment.sessionVariables.SUDO_ASKPASS =
    # Syncronised with home-manager
    config.home-manager.users."${config.var.username}".home.sessionVariables.SUDO_ASKPASS;
}
