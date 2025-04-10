{
  config,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    lsp = {
      formatOnSave = true;
      lspkind.enable = false;
      lightbulb.enable = true;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = true;

      # Maximal
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    debugger = {
      nvim-dap = {
        enable = true;
        ui = {
          enable = true;
          autoStart = true;
        };
      };
    };

    # Markdown rendering
    extraPlugins = with pkgs.vimPlugins; {
      render-markdown = {package = render-markdown-nvim;};
    };

    languages = {
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Debugger
      enableDAP = true;

      # Nim LSP is broken on Darwin and therefore
      # should be disabled by default. Users may still enable
      # `vim.languages.vim` to enable it, this does not restrict
      # that.
      # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
      nim.enable = false;

      nix.enable = true;

      # Maximal
      markdown.enable = true;
      html.enable = true;
      css.enable = true;
      sql.enable = true;
      ts.enable = true;
      lua.enable = true;
      python.enable = true;
      bash.enable = true;
      #tailwind.enable = true; # At the bottom

      clang = {
        enable = true;
        lsp.server = "clangd";
      };

      rust = {
        enable = true;
        crates = {
          enable = true;
          codeActions = true;
        };
        lsp.opts = ''
          ['rust-analyzer'] = {
            cargo = {allFeature = true},
            checkOnSave = true,
            procMacro = {
              enable = true,
            },
          },
        '';
      };
    };
    # Add Rust/Dioxus support to Tailwind lsp
    # Mix between https://dioxuslabs.com/learn/0.6/cookbook/tailwind
    # and https://github.com/NotAShelf/nvf/blob/main/modules/plugins/languages/tailwind.nix
    lsp.lspconfig.sources.tailwindcss-lsp-dioxus-support = ''
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        on_attach = default_on_attach,
        cmd = {"${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server", "--stdio"},
        filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ", "rust" },
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
            includeLanguages = {
              eelixir = "html-eex",
              eruby = "erb",
              htmlangular = "html",
              templ = "html",
              rust = "html"
            },
            experimental = {
              classRegex = {"class: \"(.*)\""}
            },
            lint = {
              cssConflict = "warning",
              invalidApply = "error",
              invalidConfigPath = "error",
              invalidScreen = "error",
              invalidTailwindDirective = "error",
              invalidVariant = "error",
              recommendedVariantOrder = "warning"
            },
            validate = true
          }
        }
      }
    '';
  };
}
