{
  inputs,
  config,
  ...
}: {
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
      # Monitoring
      "io.missioncenter.MissionCenter" # System monitoring

      # Configuration software
      "org.freedesktop.Piper" # Mouse config GUI
      "com.github.wwmm.easyeffects" # Pipewire/audio effects Manager
      "com.github.tchx84.Flatseal" # Review & modify permissions of Flatpaks

      "org.nickvision.tubeconverter" # Parabolic - Download video/audio
      "io.gitlab.liferooter.TextPieces" # Text processing
      "io.gitlab.adhami3310.Impression" # Creates bootable drives

      # Gnome
      "org.gnome.Evince" # Document Viewer
      "org.gnome.Loupe" # Image Viewer
      "org.gnome.baobab" # Disk Usage
      "org.gnome.World.PikaBackup" # Backup software

      # An improved version of Thunderbird
      # Open source email, newsfeed, chat, and calendaring client
      "eu.betterbird.Betterbird"

      # Sober - Runtime for Roblox on Linux
      {
        flatpakref = "https://sober.vinegarhq.org/sober.flatpakref";
        sha256 = "1pj8y1xhiwgbnhrr3yr3ybpfis9slrl73i0b1lc9q89vhip6ym2l";
      }
    ];
  };

  customPersist.nixos.directories = ["/var/lib/flatpak"];

  # Sober Roblox installation - which is quite large
  customPersist.home.directories = [".var/app"];
}
