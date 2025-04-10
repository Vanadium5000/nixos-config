{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium; # VS Code without MS branding/telemetry/licensing

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        asvetliakov.vscode-neovim
        mkhl.direnv
      ];
      userSettings = {
        "files.autoSave" = "off";
        #"editor.fontSize" = lib.mkForce 16;
        "editor.wordWrap" = "on";
        "window.zoomLevel" = 1.5;
      };
    };
  };

  # Custom option
  allowedUnfree = [
    "vscode-extension-MS-python-vscode-pylance"
  ];
}
