{
  inputs,
  config,
  ...
}:
{
  nix = {
    settings = {
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

      # removes ~/.nix-profile and ~/.nix-defexpr
      use-xdg-base-directories = true;

      # This also allows us to use remote builders to reduce build times and batter usage
      builders-use-substitutes = true;
      # Max number of parallel jobs
      max-jobs = "auto";

      # Substituters
      substituters = [
        #"https://cache.soopy.moe" # Apple T2
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        #"cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
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
