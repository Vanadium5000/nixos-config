{...}: {
  imports = [
    ./nh
    ./nvf
    ./pass
    ./shell
    ./tmux
    ./yazi
    ./zellij

    ./fastfetch.nix
    ./lazygit.nix
    ./rust.nix

    ../home.nix
  ];
}
