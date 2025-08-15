{ inputs, ... }:
{
  # Flatpaks are setup in the nixos module
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak # Install flatpaks declaratively
  ];

  # By default nix-flatpak will add the flathub remote
  services.flatpak.packages = [
    # Monitoring
    #"io.missioncenter.MissionCenter" # System monitoring - BROKEN
    "net.nokyan.Resources" # System monitoring

    # Configuration software
    "org.freedesktop.Piper" # Mouse config GUI
    "com.github.wwmm.easyeffects" # Pipewire/audio effects Manager
    "com.github.tchx84.Flatseal" # Review & modify permissions of Flatpaks
    "io.github.nokse22.inspector" # View lots of system information

    "org.nickvision.tubeconverter" # Parabolic - Download video/audio
    "io.gitlab.liferooter.TextPieces" # Text processing
    "io.gitlab.adhami3310.Impression" # Creates bootable drives
    "org.libreoffice.LibreOffice" # LibeOffice suite
    "org.gimp.GIMP" # GIMP - Image Editor
    "org.inkscape.Inkscape" # Inkscape - Vector Graphics Editor
    "com.github.marhkb.Pods" # Frontend for podman

    # Gnome
    "org.gnome.Evince" # Document Viewer
    "org.gnome.Loupe" # Image Viewer
    "org.gnome.baobab" # Disk Usage
    "org.gnome.World.PikaBackup" # Backup software
    "org.gnome.Evolution" # Email, contacts and schedule
    "org.gnome.Snapshot" # Camera
    "org.gnome.FileRoller" # Archives

    "fr.handbrake.ghb" # Video transpiler
  ];
}
