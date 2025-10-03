{ config, pkgs, ... }:
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
    enableSSHSupport = true; # For SSH key caching
    pinentryPackage = pkgs.pinentry-curses; # Use terminal-friendly curses backend
  };
  # Ensure GPG is available
  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-curses
  ];

  # Start sshAgent
  programs.ssh.startAgent = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  environment.variables = {
    GNUPGHOME = "/home/${config.var.username}/.gnupg";
  };

  # mtr command is a simple but effective network analysis and troubleshooting tool
  #programs.mtr.enable = true;
}
