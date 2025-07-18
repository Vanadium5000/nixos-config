{ inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.nixosModules.nix-flatpak # Install flatpaks declaratively
  ];
  # By default nix-flatpak will add the flathub remote
  services.flatpak = {
    enable = true;

    update = {
      auto = {
        enable = true;
        onCalendar = "weekly"; # Default value
      };
      onActivation = false;
    };

    uninstallUnmanaged = true;
    uninstallUnused = true; # Automatically clean up stale packages

    packages = [
      # An improved version of Thunderbird
      # Open source email, newsfeed, chat, and calendaring client
      "eu.betterbird.Betterbird"
    ];
  };

  # Persist flatpak apps
  customPersist.nixos.directories = [ "/var/lib/flatpak" ];

  # Persist flatpak storage
  customPersist.home.directories = [
    ".var/app" # Persist flatpak apps
    ".local/share/flatpak"
  ];

  # TODO: ^^^ Make flatpak persistence more selective/fix this ^^^
}
