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
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb # Rust debugging

        ms-python.python
        ms-python.debugpy

        eamodio.gitlens
        pkief.material-icon-theme
      ];

      userSettings = lib.mkForce {};
    };
  };

  home.file.".config/VSCodium/User/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/nixos-config/home-manager/desktop/vscodium/settings.json";

  # Persist settings & extensions
  customPersist.home.directories = [".config/VSCodium" ".vscode-oss/extensions"];
}
