_: {
  programs.zellij = {
    enable = true;

    settings = {
      default_shell = "fish";
      ui.pane_frames.hide_session_name = true;
    };
  };

  xdg.configFile."zellij/layouts/default.kdl".text = ''
    layout {
        pane borderless=true
        pane size=1 borderless=true {
            plugin location="zellij:tab-bar"
        }
    }
  '';
}
