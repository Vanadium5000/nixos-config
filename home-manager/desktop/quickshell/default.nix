{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./packages.nix # Caelestia scripts and quickshell wrapper derivations
    ./caelestia-quickshell.nix # Caelestia quickshell cli
  ];

  home.packages = with pkgs; [
    (inputs.quickshell.packages."${pkgs.system}".default.override {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = true;
      withPipewire = true;
      withPam = true;
      withHyprland = true;
    })

    # dependencies for caelestia-dots
    git
    curl
    jq
    material-symbols
    ibm-plex
    fd
    nerd-fonts.jetbrains-mono
    material-design-icons # for material-symbols
    ibm-plex
    jetbrains-mono

    gtk3 # for gtk-launch
  ];

  xdg.configFile."quickshell/caelestia".source = "${inputs.caelestia-shell}";
  # Fish completions (a fixed version?)
  xdg.configFile."fish/completions/caelestia.fish".source = ./caelestia-completions.fish;

  home.file."Pictures/Wallpapers".source = "${pkgs.nixy-wallpapers}/wallpapers/";

  systemd.user.services.caelestia-shell = {
    Unit = {
      Description = "Quickshell UI";
      After = "graphical-session.target";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.fish}/bin/fish -c %h/.config/quickshell/caelestia/run.fish";
      Restart = "on-failure";
      Slice = "app-graphical.slice";
    };
  };

  # Shell aliases
  home.shellAliases = {
    caelestia-shell = "qs -c caelestia";
    caelestia-edit = "cd ${config.xdg.configHome}/quickshell/caelestia && $EDITOR";
    caelestia = "caelestia-quickshell";
  };
}
