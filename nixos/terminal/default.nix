{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    #./fenix.nix
    ./fonts.nix
    ./packages.nix
    ./pager.nix
  ];

  home-manager = lib.mkDefault {
    extraSpecialArgs = {
      inherit inputs; # settings;
    };
    users.${config.var.username} = import ../../home-manager/terminal;
  };

  # Enables fish/zsh
  environment.shells = with pkgs; [nushell fish zsh];
  programs = {
    fish.enable = true;
    zsh.enable = true;

    # Requires channel
    command-not-found.enable = false;
  };

  # More secure
  security.doas = {
    enable = false;

    extraRules = [
      {
        # Optional, retains environment variables while running commands
        # e.g. retains your NIX_PATH when applying your config
        keepEnv = true;
        persist = true; # Optional, don't ask for the password for some time, after a successfully authentication
      }
    ];
  };
  security.sudo.enable = true;
}
