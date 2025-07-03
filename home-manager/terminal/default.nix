{...}: {
  imports = [
    ./nh
    ./nvf
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
}
