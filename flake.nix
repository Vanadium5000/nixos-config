{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # If using a stable channel you can use `url = "github:nixos/nixpkgs/nixos-<version>"`
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    # Also see the 'unstable-packages'/'stable-packages' overlay at 'overlays/default.nix'

    # Nix User Repository: User contributed nix packages
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";
    # Hyprland official plugins
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # Overview plugin
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };

    # Hyprpanel
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    # Provides hyprpanel pkg via overlay
    # Hyprpolkitagent
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    # A simple polkit authentication agent for Hyprland
    # Hyprsunset
    hyprsunset.url = "github:hyprwm/hyprsunset";
    # An application to enable a blue-light filter on Hyprland

    # Shell using QtQuick, used for panels/bars/widgets/etc.
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox extensions
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # A nix flake for configuring spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust toolchains and rust-analyzer nightly for Nix
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Install flatpaks declaratively
    # https://github.com/gmodena/nix-flatpak
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      # If using a stable channel you can use `url = "github:nix-community/home-manager/release-<version>"`
      # For unstable, `url = "github:nix-community/home-manager"`
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stylix
    stylix.url = "github:danth/stylix";
    # If using a stable channel you can use `url = "github:danth/stylix/release-<version>"`
    # For unstable, `url = "github:danth/stylix"`

    # Apple fonts
    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";

    # Nvf
    nvf = {
      url = "github:notashelf/nvf";
      # you can override input nixpkgs
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware configs/drivers
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; #/cceee0a31d2f01bcc98b2fbd591327c06a4ea4f9";

    # Declarative disk partitioning
    # disko = {
    #   url = "github:nix-community/disko/latest";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Handles persistent state on systems with ephemeral root storage
    impermanence.url = "github:nix-community/impermanence";
    # Retroactively persist directories with impermanence - copies files/folders to persist once added instead of deleting & making new - doesn't loose data
    persist-retro.url = "github:Geometer1729/persist-retro";

    caelestia-shell = {
      url = "github:liperium/caelestia-shell";
      flake = false;
    };
    caelestia-scripts = {
      url = "github:ItzDerock/caelestia-scripts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    #disko,
    impermanence,
    #persist-retro,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

    nixosConfig = file:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs; # settings;
        };
        modules = [
          file # hosts/x.nix file

          ./common

          home-manager.nixosModules.home-manager # Home manager

          #disko.nixosModules.disko # Declarative disk partitioning
          impermanence.nixosModules.impermanence # Handles persistent state on systems with ephemeral root storage
          #persist-retro.nixosModules.persist-retro # Retroactively persist directories with impermanence - copies files/folders to persist once added instead of deleting & making new - doesn't loose data
        ];
      };
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#configuration-name'
    nixosConfigurations = {
      legion5i = nixosConfig ./hosts/legion5i;
      macbook = nixosConfig ./hosts/macbook;
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe" # Apple T2
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
