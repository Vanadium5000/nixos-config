# Utility (script) for automatically syncing git repos every 2 seconds
{ config, ... }:
{
  services.gitwatch = {
    password-store = {
      enable = true;
      path = "/home/${config.var.username}/.local/share/password-store";
      remote = "git@github.com:Vanadium5000/passwords.git";
      user = config.var.username;
    };
  };
}
