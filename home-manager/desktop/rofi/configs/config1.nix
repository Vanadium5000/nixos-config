{ config, ... }:
let
  clrs = config.var.colors;
  clrs-rgba = config.var.colors-rgba thme.bar.opacity;
  stylix = config.var.stylix;
  thme = config.var.theme;
  radius = toString thme.button-rounding;

  #backgroundOpacity = builtins.floor (builtins.mul thme.launcher.opacity 100);

  fontSize = "${toString config.stylix.fonts.sizes.desktop}";

  inherit (thme.bar) font;
in
{
  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      drun-display-format: "{icon} {name}";
      font: "${font} Bold ${fontSize}";
      modi: "window,run,drun,emoji,calc,";
      show-icons: true;
      //icon-theme: "Rose Pine";
      sort: true;
      case-sensitivity: false; 
      sorting-method: "fzf";
      hide-scrollbar: false;
      terminal: "kitty";
      display-drun: "   Apps ";
      display-run: "   Run ";
      display-window: "  Window";
      display-Network: " 󰤨  Network";
      display-emoji: "  Emoji  ";
      display-calc: "  Calc";
      sidebar-mode: true;
      hover-select: true;

      steal-focus: false;
      scroll-method: 1; /* continuous (not per page) */
      normal-window: true; /* Make rofi react like a normal application window */

      run,drun {
        fallback-icon: "utilities-terminal";
      }

      }



    * {
        bg:  ${clrs-rgba.background};
        bg-opaque: ${clrs.background};
        fgd: ${clrs.foreground};
        cya: #${stylix.base0C};
        grn: #${stylix.base0B};
        ora: #${stylix.base09};
        pur: #${stylix.base0F};
        red: #${stylix.base08};
        yel: #${stylix.base0A};
        acc: ${clrs.accent};
        acc-alt: ${clrs.accent-alt};


        foreground: @fgd;
        background: @bg;
        background-opaque: @bg-opaque;
        active-background: @acc;
        urgent-background: @red;

        selected-background: @active-background;
        selected-urgent-background: @urgent-background;
        selected-active-background: @active-background;
        separatorcolor: @active-background;
        bordercolor: ${clrs.border-color};

        /* Reset all styles */
        border-radius: ${radius}px;
        min-height: 0;
        margin: 0;
        padding: 0px;
        padding-left: 0px;
        padding-right: 0px;
        //background: transparent;
    }

    #window {
        background-color: @background;
        border:           ${toString thme.border-size};
        border-radius: ${toString thme.rounding};
        border-color: @bordercolor;
        padding:          5;
    }
    #mainbox {
        border:  0;
        padding: 5;
    }
    #message {
        border:       ${toString thme.border-size}px dash 0px 0px ;
        border-color: @separatorcolor;
        padding:      1px ;
    }
    #textbox {
        text-color: @foreground;
    }
    #listview {
        fixed-height: 0;
        border:       ${toString thme.border-size}px dash 0px 0px ;
        border-color: @bordercolor;
        spacing:      2px ;
        scrollbar:    false;
        padding:      2px 0px 0px ;
    }
    #element {
        border:  0;
        padding: 1px ;
    }
    /* Get rid of @background (use transparent instead) for elements to avoid double opacity bad-looking ui */
    #element.normal.normal {
        background-color: transparent;
        text-color:       @foreground;
    }
    #element.normal.urgent {
        background-color: @urgent-background;
        text-color:       @urgent-foreground;
    }
    #element.normal.active {
        background-color: @active-background;
        text-color:       @background-opaque;
    }
    #element.selected.normal {
        background-color: @selected-background;
        text-color:       @background-opaque;
    }
    #element.selected.urgent {
        background-color: @selected-urgent-background;
        text-color:       @foreground;
    }
    #element.selected.active {
        background-color: @selected-active-background;
        text-color:       @background-opaque;
    }
    #element.alternate.normal {
        background-color: transparent;
        text-color:       @foreground;
    }
    #element.alternate.urgent {
        background-color: @urgent-background;
        text-color:       @foreground;
    }
    #element.alternate.active {
        background-color: @active-background;
        text-color:       @foreground;
    }
    #scrollbar {
        width:        2px ;
        border:       0;
        handle-width: 8px ;
        padding:      0;
    }
    #sidebar {
        border:       ${toString thme.border-size}px dash 0px 0px ;
        border-color: @separatorcolor;
    }
    #button.selected {
        background-color: @selected-background;
        text-color:       @background-opaque;
    }
    #inputbar {
        spacing:    0;
        text-color: @foreground;
        padding:    1px ;
    }
    #case-indicator {
        spacing:    0;
        text-color: @foreground;
    }
    #entry {
        spacing:    0;
        text-color: @cya;
    }
    #prompt {
        spacing:    0;
        text-color: @fgd;
    }
    #inputbar {
        children:   [ prompt,textbox-prompt-colon,entry,case-indicator ];
    }
    #textbox-prompt-colon {
        expand:     false;
        str:        ":";
        margin:     0px 0.3em 0em 0em ;
        text-color: @fgd;
    }'';
}
