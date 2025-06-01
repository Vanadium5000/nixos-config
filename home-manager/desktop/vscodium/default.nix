{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages (ps: with ps; [rustup zlib]);

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Rust
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb # Rust debugging

        # Python
        ms-python.python
        ms-python.debugpy
        ms-python.black-formatter
        ms-python.mypy-type-checker
        ms-python.pylint

        # General
        eamodio.gitlens
        pkief.material-icon-theme

        # AI
        continue.continue
      ];

      userSettings = lib.mkForce {};
    };
  };

  home.file.".config/VSCodium/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/nixos-config/home-manager/desktop/vscodium/settings.json";

  # Persist settings & extensions, ".continue" contains settings for the Continue ai extension
  customPersist.home.directories = [".config/VSCodium" ".vscode-oss/extensions" ".continue"];
}
