{pkgs, ...}: {
  programs.nvf.settings.vim.lazy.plugins = {
    "better-escape.nvim" = {
      package = pkgs.vimPlugins.better-escape-nvim;
      setupModule = "better-escape";
      setupOpts = {
        timeout = 300;
      };
      lazy = true;
      event = "User BaseDefered";
    };
  };
}
