{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    #./fenix.nix
    ./packages.nix
    ./pager.nix
    ./postgresql.nix
  ];

  # Desktop is higher priority with lib.mkForce
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users.${config.var.username} = import ../../home-manager/terminal;
  };

  # Disable the slow "building man-cache" step
  documentation.man.generateCaches = lib.mkForce false;

  # Enables fish/zsh
  environment.shells = with pkgs; [
    nushell
    fish
    zsh
  ];
  programs = {
    fish.enable = true;
    zsh.enable = true;

    # Requires channel
    command-not-found.enable = false;
  };

  # Enable Polkit
  security.polkit.enable = true;

  # # Doas is leaner and more secure
  # security.doas = {
  #   enable = true;

  #   extraRules = [
  #     {
  #       # The usernames / UIDs this rule should apply for
  #       users = [ config.var.username ];

  #       # Optional, retains environment variables while running commands
  #       # e.g. retains your NIX_PATH when applying your config
  #       #keepEnv = true; # Problematic
  #       persist = true; # Optional, don't ask for the password for some time, after a successfully authentication
  #     }
  #   ];
  # };

  # # Disable & replace Sudo
  # security.sudo.enable = false;
  # environment.shellAliases = {
  #   sudo = "doas";
  # };

  # Git is a bitch
  security.sudo = {
    enable = true;
    extraConfig = ''
      Defaults lecture = never
      Defaults pwfeedback
      Defaults insults
      Defaults env_keep += "EDITOR PATH DISPLAY SUDO_ASKPASS"
    '';
  };

  # Fedora enables these options by default. See the 10-oomd-* files here:
  # https://src.fedoraproject.org/rpms/systemd/tree/acb90c49c42276b06375a66c73673ac3510255
  systemd.oomd = {
    enable = lib.mkForce true;
    enableRootSlice = lib.mkDefault true;
    enableUserSlices = lib.mkDefault true;
    enableSystemSlice = lib.mkDefault true;
  };
}
