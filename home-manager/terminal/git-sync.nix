{ config, ... }:
{
  services.git-sync = {
    enable = true;
    repositories = {
      passwords = {
        uri = "git@github.com:Vanadium5000/passwords.git";
        path = "/home/${config.var.username}/.local/share/password-store";
        interval = 300;
      };
    };
  };
}
