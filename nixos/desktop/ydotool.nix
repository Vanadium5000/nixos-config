{ pkgs, ... }:
{
  # Generic command-line automation tool (macro/autoclicker)
  programs.ydotool = {
    # Whether to enable ydotoold system service and ydotool for members of programs.ydotool.group
    enable = true;
  };

  # An easy to use tool to change the mapping of your input device buttons
  services.input-remapper.enable = true;

  # Add the ydotool application
  environment.systemPackages = with pkgs; [
    ydotool
    input-remapper
  ];
}
