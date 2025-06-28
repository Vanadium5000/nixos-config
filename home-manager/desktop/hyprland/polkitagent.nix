{pkgs, ...}: {
  # Install hyprpolkitagent package
  home.packages = with pkgs; [
    hyprpolkitagent # Polkit authentication agent for Hyprland
  ];

  # Enable hyprpolkitagent service
  services.hyprpolkitagent.enable = true;
}
