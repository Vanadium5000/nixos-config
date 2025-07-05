{ config, ... }:
{
  programs.git = {
    enable = true;
    extraConfig = {
      user = {
        email = "vanadium5000@gmail.com";
        name = "vanadium5000";
      };
      diff = {
        algorithm = "patience";
        colorMoved = "zebra";
      };
      color = {
        ui = "auto";
        branch = "auto";
        diff = "auto";
        status = "auto";
        showbranch = "auto";
      };
      merge = {
        tool = "nvim";
        renamelimit = 20000;
      };
      mergetool = {
        prompt = false;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      core = {
        autocrlf = "input";
      };
      credential = {
        helper = "cache";
      };
      init = {
        defaultBranch = "main";
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      fetch = {
        prune = true;
      };
      push = {
        autoSetupRemote = true;
      };
      column = {
        ui = "auto";
      };
      # Solution to issue "opening Git repository ...: repository path ... is not owned by current user"
      safe = {
        directory = config.var.configDirectory;
      };
    };
  };
}
