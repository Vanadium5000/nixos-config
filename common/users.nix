{
  pkgs,
  config,
  ...
}:
{
  # Defines system-wide user settings (groups, etc)
  users.users = {
    ${config.var.username} = {
      isNormalUser = true;
      shell = pkgs.fish; # Default shell

      # Don't forget to set a different password with "passwd" after rebooting!
      initialPassword = "1234";

      # Add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "video"
        "libvirtd"
        "podman"
        "docker"
        "ollama"
        "ydotool" # Macro/autoclicker tool
        "gamemode"
      ];
    };
  };
}
