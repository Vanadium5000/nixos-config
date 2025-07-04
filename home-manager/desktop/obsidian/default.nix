{ ... }:
{
  imports = [ ./theme.nix ];

  # Enable custom stylix module for theming
  stylix.targets.obsidian = {
    enable = true;
    vaults = [ "Vault" ];
  };

  # Add Obsidian using flatpak
  services.flatpak.packages = [
    # Utility
    "md.obsidian.Obsidian"
  ];
}
