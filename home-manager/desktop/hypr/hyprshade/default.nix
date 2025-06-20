{pkgs, ...}: {
  home.file.".config/hypr/hyprshade.toml" = {
    text = ''
      [[shades]]
      name = "vibrance"
      default = true

      [[shades]]
      name = "blue-light-filter"
      start_time = 19:00:00
      end_time = 22:15:00

      [[shades]]
      name = "grayscale"
      start_time = 22:15:00
      end_time = 06:30:00
    '';
  };
  home.file.".config/hypr/shaders/grayscale.glsl".source = ./grayscale.glsl;
  home.file.".config/hypr/shaders/blue-light-filter.glsl.mustache".source = ./blue-light-filter.glsl.mustache;

  wayland.windowManager.hyprland.settings = {
    exec = [
      "${pkgs.hyprshade}/bin/hyprshade auto"
    ];
  };
}
