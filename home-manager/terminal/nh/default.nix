{
  pkgs,
  config,
  ...
}:
{
  # NH reimplements some basic nix commands.
  # Adding functionality on top of the existing solutions, like nixos-rebuild, home-manager cli or nix itself.
  programs.nh = {
    enable = true;
    flake = config.var.configDirectory;
  };

  home.packages = with pkgs; [
    nix-output-monitor # Processes output of Nix commands to show helpful and pretty information
    nvd # Nix/NixOS package version diff tool
  ];
}
