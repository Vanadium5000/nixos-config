{inputs, ...}: {
  # Flatpaks are setup in the nixos module
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak # Install flatpaks declaratively
  ];

  # By default nix-flatpak will add the flathub remote
  services.flatpak.packages = [
    # Sober - Runtime for Roblox on Linux
    "org.vinegarhq.Sober"
  ];
}
