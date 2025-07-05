{ pkgs, ... }:
{
  # Protect your eyes from eye strain with reminders to rest, etc.
  home.packages = with pkgs; [ safeeyes ];
  services.safeeyes.enable = true;
}
