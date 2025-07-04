{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (discord.override {
      # withOpenASAR = true; # can do this here too
      withVencord = true;
    })
  ];

  # Custom option
  allowedUnfree = [
    "discord"
  ];

  # Persist settings & extensions
  customPersist.home.directories = [
    ".config/discord"
    ".config/Vencord"
  ];
}
