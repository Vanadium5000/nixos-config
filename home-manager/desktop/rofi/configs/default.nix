{...}: let
  configs = {
    "Modern Cool" = "";
    "Rounded Mess" = ./config2.nix;
  };
in {
  imports = [
    ./config1.nix
    ./config2.nix
  ];
}
