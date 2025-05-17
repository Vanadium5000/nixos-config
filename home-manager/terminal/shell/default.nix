# Shell config
{pkgs, ...}: {
  imports = [
    ./aliases.nix
    ./btop.nix
    ./command-not-found.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./nushell.nix
    ./starship.nix
    ./tldr.nix
  ];

  programs.bash = {
    enable = true;
    # Disables bash history
    initExtra = "unset HISTFILE";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      ignoreAllDups = true;
      ignoreSpace = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };

    initContent = builtins.concatStringsSep "\n" [
      # Disables case-sensitivity
      "zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'"
      # Colours completions like ls --color
      "zstyle ':completion:*' list-colors \"\${(s.:.)LS_COLORS}\""
      # Disables default menu
      "zstyle ':completion:*' menu no"

      # https://github.com/zsh-users/zsh-history-substring-search
      "bindkey '^[[A' history-substring-search-up" # Up arrow
      "bindkey '^[[B' history-substring-search-down" # Down arrow
      "bindkey '^[OA' history-substring-search-up" # Up arrow
      "bindkey '^[OB' history-substring-search-down" # Down arrow
    ];

    # Enables tab-completion using fzf
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "v1.1.2";
          sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
        };
      }
    ];
  };
}
