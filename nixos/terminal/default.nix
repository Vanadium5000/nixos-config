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
    extraConfig = {
      "DefaultMemoryPressureDurationSec" = "20s";
    };
  };
}
