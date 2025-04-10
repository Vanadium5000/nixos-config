_: {
  programs.nvf.settings.vim = {
    telescope = {
      enable = true;
      setupOpts = {
        defaults = {
          file_ignore_patterns = [
            "node_modules"
            ".git/"
            ".direnv/"
            ".svelte-kit/"
            "dist/"
            "build/"
            "target/"
            "result/"
            # Lockfiles
            "flake.lock"
            "flake.lock.bak"
          ];
        };

        pickers.find_files.hidden = true;
      };
    };
  };
}
