# Eza is an ls replacement
{
  programs.eza = {
    enable = true;
    icons = "auto";

    extraOptions = [
      "--group-directories-first"
      "--no-quotes"
      "--all"
      "--icons=always"
      "--show-symlinks"
    ];
  };
}
