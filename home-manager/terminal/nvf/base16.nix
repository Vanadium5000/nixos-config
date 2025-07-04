{
  config,
  pkgs,
  ...
}:
let
  plugin = "base16-nvim"; # "base16-nvim" | "mini.base16"
in
{
  programs.nvf.settings.vim.extraPlugins =
    if plugin == "base16-nvim" then
      {
        base16-nvim = {
          package = pkgs.vimPlugins.base16-nvim;
          setup = with config.lib.stylix.colors.withHashtag; ''
            require('base16-colorscheme').setup({
              base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
              base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
              base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
              base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
            })
          '';
        };
      }
    else
      {
        mini-nvim = {
          package = pkgs.vimPlugin.mini-nvim;
          setup = with config.lib.stylix.colors.withHashtag; ''
            require('mini.base16').setup({
              palette = {
                base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
                base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
                base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
                base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
              }
            })
          '';
        };
      };
}
