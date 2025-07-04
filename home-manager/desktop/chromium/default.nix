{ config, ... }:
{
  # Brave browser
  # Note: most of the config is in nixos/desktop/chromium, not here

  # Save Bookmarks in config in a mutable way
  home.file.".config/BraveSoftware/Brave-Browser/Default/Bookmarks" = {
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.var.configDirectory}/home-manager/desktop/chromium/Bookmarks";
  };
  # Persist data of the Brave browser
  customPersist.home.directories = [ ".config/BraveSoftware" ];
}
