{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    swww
    inputs.matugen.packages.${system}.default
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
    networkmanager
    gtk3

    # Added after
    inputs.ags.packages.${pkgs.system}.notifd
    inputs.ags.packages.${pkgs.system}.mpris
    material-symbols
  ];

  programs.ags = {
    enable = true;
    configDir = ./ags;
    extraPackages = with pkgs; [
      accountsservice

      # Added after
      pkgs.libsoup_3
      pkgs.gtksourceview
      pkgs.libnotify
      pkgs.webkitgtk_4_1
      pkgs.gst_all_1.gstreamer
      inputs.ags.packages.${pkgs.system}.apps
      # inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.bluetooth
      # inputs.ags.packages.${pkgs.system}.auth
      pkgs.libgtop
    ];
  };
}
