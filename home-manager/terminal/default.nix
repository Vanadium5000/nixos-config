{ pkgs, inputs, ... }:
{
  imports = [
    ./nh
    ./pass
    ./shell
    #./tmux
    ./yazi
    ./zellij

    ./fastfetch.nix
    ./git.nix
    ./lazygit.nix
    ./rust.nix

    ../home.nix
  ];

  home.packages = [
    # My Neovim config using NVF
    inputs.nvf-neovim.packages.${pkgs.system}.default
  ];
}
