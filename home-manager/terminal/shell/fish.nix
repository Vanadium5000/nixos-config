{
  pkgs,
  ...
}:
{
  programs = {
    fish = {
      enable = true;

      shellInit = ''
        #fastfetch
        # shut up welcome message
        set fish_greeting

        # set options for plugins
        set sponge_regex_patterns 'password|passwd'

        # bind --mode default \t complete-and-search
      '';
      # setup vi mode
      interactiveShellInit = ''
        fish_vi_key_bindings
      '';
    };
  };

  # fish plugins, home-manager's programs.fish.plugins has a weird format
  home.packages =
    with pkgs;
    [
      fzf
    ]
    ++ (with pkgs.fishPlugins; [
      sponge # do not add failed commands to history
      done # send notification once long-running commands finish
      fzf-fish # fzf for fish
      forgit # fzf-powered interactive git commands
    ]);

  # set as default interactive shell
  #programs.kitty.settings.shell = lib.mkForce (lib.getExe pkgs.fish);
  #custom.ghostty.config.command = lib.mkForce (lib.getExe pkgs.fish);

  #custom.persist = {
  #  home = {
  #    cache.directories = [".local/share/fish"];
  #  };
  #};
}
