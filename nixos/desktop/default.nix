{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./chromium

    ./apps.nix
    ./audio.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./gaming.nix
    ./hyprland.nix
    ./nix-ld.nix
    ./ollama.nix
    ./packages.nix
    ./stylix.nix
    ./syncthing.nix
    ./tuigreet.nix
    ./virtualisation.nix
    #./ydotool.nix
  ];

  home-manager = {
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

    dbus.enable = true;
  };

  # Whether to enable KDE PIM base packages
  programs.kde-pim = {
    enable = true;

    merkuro = true; # Calendar & contacts
    kontact = true; # Contacts
    kmail = true; # Mail
  };

  # NetworkManager control applet for GNOME
  programs.nm-applet.enable = true;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
