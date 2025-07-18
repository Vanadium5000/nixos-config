{
  inputs,
  config,
  ...
}:
{
  nix = {
    settings = rec {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      #flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;

      # A list of names of users that have additional rights when connecting to the Nix daemon, such as the ability to specify additional binary caches
      trusted-users = [
        config.var.username
        "root"
        "@wheel"
      ];

      # Users that are allowed to connect to the Nix daemon, default is *
      allowed-users = [
        config.var.username
        "root"
        "@wheel"
      ];

      # Performance optimizations
      max-jobs = "auto"; # Use all available cores for building - default is 1, int or "auto"
      cores = 0; # Use all available cores per build job

      # Binary cache optimisations
      # TODO: I would use 128 for both but the RAM usage seems to be astronomical
      http-connections = 32; # Max number of parallel TCP connections - default is 25
      max-substitution-jobs = 32; # Max number of substitution jobs in parallel - default is 16

      # Substituters
      # NOTE: ?priority={num} specificies the priority of the substituter
      # NOTE: All of this is duplicated both in flake.nix and common/nix.nix
      # Lower means more priority - cache.nixos.org defaults to 40 priority so it is unchanged
      substituters = [
        "https://cache.nixos.org?priority=40"
        "https://hyprland.cachix.org?priority=45"
        "https://nix-community.cachix.org?priority=50"
        "https://cache.soopy.moe?priority=55" # Apple T2
      ];
      trusted-substituters = substituters;
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo=" # Apple T2
      ];

      # removes ~/.nix-profile and ~/.nix-defexpr
      use-xdg-base-directories = true;
    };

    # Opinionated: disable channels
    channel.enable = false;

    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    # Save space by hardlinking store files
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    # Remove old generations, unnecessary software, etc.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
