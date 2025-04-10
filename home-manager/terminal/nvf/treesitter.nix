{pkgs, ...}: {
  programs.nvf.settings.vim = {
    treesitter = {
      enable = true;

      addDefaultGrammars = true;
      grammars = [
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.typescript
        pkgs.vimPlugins.nvim-treesitter.builtGrammars.qmljs
      ];
      autotagHtml = true;
      fold = true;

      context.enable = true; # enable context of current buffer
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
