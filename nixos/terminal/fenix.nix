{
  pkgs,
  inputs,
  config,
  ...
}: let
  fenixStable = with pkgs.fenix;
    combine [
      (stable.withComponents ["cargo" "clippy" "rust-src" "rustc" "rustfmt" "llvm-tools-preview"])
      targets.wasm32-unknown-unknown.stable.rust-std
    ];
in {
  # Add cargo to path
  # environment.pathsToLink = [
  #   "$HOME/.cargo/bin"
  # ];

  home-manager.users.${config.var.username} = {
    home.sessionPath = [".cargo/bin"];
  };

  # Persist .cargo
  customPersist.home.directories = [".cargo"];

  nixpkgs.overlays = [inputs.fenix.overlays.default];
  environment.systemPackages = [fenixStable];
}
