# starship is a minimal, fast, and extremely customizable prompt for any shell!
{
  config,
  lib,
  ...
}:
let
  accent = "#${config.lib.stylix.colors.base0D}";
  background-alt = "#${config.lib.stylix.colors.base01}";
in
{
  programs.starship = {
    enable = true;

    settings = {
      format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";
      git_branch = {
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
        style = "bg:#394260";
        symbol = "";
      };
      directory = {
        format = "[ $path ]($style)";
        style = "fg:#090c0c bg:#769ff0";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      git_status = {
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        style = "bg:#394260";
      };
      golang = {
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        style = "bg:#212736";
        symbol = "";
      };
      nodejs = {
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        style = "bg:#212736";
        symbol = "";
      };
      php = {
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        style = "bg:#212736";
        symbol = "";
      };
      rust = {
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        style = "bg:#212736";
        symbol = "";
      };
      nix_shell = {
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
        style = "bg:#212736";
        symbol = "";
      };
      time = {
        disabled = false;
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
        style = "bg:#1d2230";
        time_format = "%R"; # Hour:Minute Format
      };
    };
  };
}
