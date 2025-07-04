{ pkgs, ... }:
{
  # Use neovim as pager
  environment.systemPackages = with pkgs; [ page ];

  # Set "page" as default pager
  environment.sessionVariables = {
    PAGER = "page";
    MANPAGER = "page";
  };
}
