{
  lib,
  config,
  ...
}: {
  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
    allowedUnfree = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
    };
    # Persist options
    customPersist = {
      # Nixos
      nixos = {
        directories = lib.mkOption {
          type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
          default = [];
        };
        files = lib.mkOption {
          type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
          default = [];
        };
      };
      # Home
      home = {
        directories = lib.mkOption {
          type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
          default = [];
        };
        files = lib.mkOption {
          type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
          default = [];
        };
      };
    };
  };

  imports = [
    ./colors.nix
  ];

  config.var = {
    username = "ac";

    # Set by hosts/x.nix file
    #hostname = "nxs";

    configDirectory =
      "/home/"
      + config.var.username
      + "/.config/nixos"; # The path of the nixos configuration directory

    keyboardLayout = "gb";

    location = "London";
    timeZone = "Europe/London";
    locale = "en_GB.UTF-8";
  };
}
