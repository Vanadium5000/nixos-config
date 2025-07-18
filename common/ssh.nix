{ config, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = false;
    };
  };

  # OpenPGP, tools/management of keys, etc.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  environment.variables = {
    GNUPGHOME = "/home/${config.var.username}/.gnupg";
  };

  # mtr command is a simple but effective network analysis and troubleshooting tool
  #programs.mtr.enable = true;
}
