{lib, ...}: {
  programs.nvf.settings.vim = {
    # CodeCompanion - AI-powered coding, seamlessly in Neovim
    assistant.codecompanion-nvim = {
      enable = true;
      setupOpts = {
        adapters =
          lib.generators.mkLuaInline
          # lua
          ''
            {
              l = function ()
                return require("codecompanion.adapters").extend("ollama", {
                  name = "l",
                  schema = {
                    model = {
                      default = "deepseek-r1:14b",
                    }
                  }
                })
              end
            }
          '';
        strategies = {
          chat.adapter = "l";
          inline.adapter = "l";
        };
        display.diff.provider = "mini_diff";
      };
    };
  };
}
