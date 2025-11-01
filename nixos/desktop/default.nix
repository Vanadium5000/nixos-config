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

  # environment.systemPackages = with pkgs; [

  #   libsecret # Required by Chromium and VSCodium for storing secrets
  #   kdePackages.polkit-kde-agent-1 # Provides the authentication dialog for Plasma/Dolphin
  # ];

  # GUI password prompt for SUDO
  environment.sessionVariables.SUDO_ASKPASS =
    # Syncronised with home-manager
    config.home-manager.users."${config.var.username}".home.sessionVariables.SUDO_ASKPASS;

  services.gnome.gcr-ssh-agent.enable = lib.mkForce false;

  # Install KDE Polkit agent + Qt support
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    kdePackages.polkit-kde-agent-1
    kdePackages.polkit-qt-1 # Ensures Qt apps like Dolphin integrate smoothly
  ];

  # Auto-start via systemd user service (activates on graphical login for all users)
  systemd.user.services.polkit-kde-agent-1 = {
    description = "KDE Polkit Authentication Agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
