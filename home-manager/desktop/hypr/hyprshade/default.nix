{pkgs, ...}: {
  home.file.".config/hypr/hyprshade.toml" = {
    text = ''
      [[shades]]
      name = "vibrance"
      default = true

      [[shades]]
      name = "a_greyscale"
      start_time = 22:15:00
      end_time = 06:30:00

      [[shades]]
      name = "blue-light-filter"
      start_time = 19:00:00
      end_time = 06:00:00
    '';
  };
  home.file.".config/hypr/shaders/a_greyscale.glsl".source = ./greyscale.glsl;

  wayland.windowManager.hyprland.settings = {
    exec = [
      "${pkgs.hyprshade}/bin/hyprshade auto"
    ];
  };
}
