{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    (
      # General CLI tools
      [
        git
        git-ignore # Quickly and easily fetch .gitignore templates from gitignore.io
        wget
        curl

        fzf
        fd
        ripgrep
        bc # Calculator

        tealdeer # Very fast implementation of tldr in Rust
        btop # System resource monitor
        bat
        zip
        unzip
        jq
        neovim

        fastfetch # Device info
        cpufetch # CPU info
        nix-tree # Nix storage info
      ]
      ++
        # Language runtimes/compilers
        [
          python3
          gcc
          bun
          go
        ]
      ++
        # Just cool
        [
          pipes
          cmatrix
          cava
        ]
      ++
        # LSPs/code-formatters
        [
          alejandra
          nixfmt-rfc-style # Nix formatter
        ]
    );
}
