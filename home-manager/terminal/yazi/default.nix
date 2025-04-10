# Yazi is a TUI file explorer
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      manager = {
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        linemode = "size";
        show_hidden = true;
        sort_dir_first = true;

        # Better defaults
        ratio = [
          0
          1
          1
        ];
      };
    };

    # Better defaults
    theme = {
      manager = {
        preview_hovered = {
          underline = true;
        };
        folder_offset = [
          1
          0
          1
          0
        ];
        preview_offset = [
          1
          1
          1
          1
        ];
      };
    };
  };
}
