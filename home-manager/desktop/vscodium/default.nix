{
  pkgs,
  config,
  lib,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhsWithPackages (
      ps: with ps; [
        rustup
        zlib
        openssl.dev
        pkg-config
      ]
    );

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Rust
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb # Rust debugging

        # TOML
        tamasfe.even-better-toml # Support for Cargo.toml

        # Python
        ms-python.python
        ms-python.debugpy
        ms-python.black-formatter
        ms-python.mypy-type-checker
        ms-python.pylint

        # Web dev
        bradlc.vscode-tailwindcss
        esbenp.prettier-vscode
        svelte.svelte-vscode # Svelte

        # Go
        golang.go

        # Nix
        jnoortheen.nix-ide

        # General
        eamodio.gitlens
        ms-azuretools.vscode-containers
        pkief.material-icon-theme
        usernamehw.errorlens # Improves error highlighting
        fill-labs.dependi # Helps manage dependencies
        #streetsidesoftware.code-spell-checker
        gruntfuggly.todo-tree # Show TODOs, FIXMEs, etc. comment tags in a tree view
        mkhl.direnv # Direnv for VSCodium

        # AI
        continue.continue
        saoudrizwan.claude-dev # Cline - Autonomous AI coding agent
      ];

      userSettings = lib.mkForce { };
    };
  };

  # LSPs/Dependencies
  home.packages = with pkgs; [
    nixd
    nil
    nixfmt-rfc-style # Nixfmt
    nixfmt-tree # Nixfmt-tree
    alejandra
  ];

  # Custom option
  allowedUnfree = [
    "vscode-extension-fill-labs-dependi"
  ];

  home.file.".config/VSCodium/User/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.var.configDirectory}/home-manager/desktop/vscodium/settings.json";

  # Persist settings & extensions, ".continue" contains settings for the Continue ai extension
  customPersist.home.directories = [
    ".config/VSCodium"
    ".vscode-oss/extensions"
    ".continue"
  ];
}
