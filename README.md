<h1 align=center>My nixos-config</h1>

<div align=center>

![GitHub last commit](https://img.shields.io/github/last-commit/Vanadium5000/nixos-config?style=for-the-badge&labelColor=101418&color=9ccbfb)
![GitHub Repo stars](https://img.shields.io/github/stars/Vanadium5000/nixos-config?style=for-the-badge&labelColor=101418&color=b9c8da)
![GitHub repo size](https://img.shields.io/github/repo-size/Vanadium5000/nixos-config?style=for-the-badge&labelColor=101418&color=d3bfe6)

</div>

## 🎥 Preview

https://github.com/user-attachments/assets/da4de2c0-ea73-4efa-b366-21cb4f55e0a0

## 📋 Overview

This is my personal nixos-config as of now. I use this config day-to-day for all my online activities, as well as web & program development using languages such as Rust, Go, Typescript, & Python. I try and keep the nix code well-documented and mostly generic, I plan to add more modularisation & make the whole repo a module that can be used in other configs. I would be happy if people benefit from my config; it has a few good features.

## 📓 Components

| Component                |                                            Software                                            |
| ------------------------ | :--------------------------------------------------------------------------------------------: |
| **Window Manager**       |                           [Hyprland](home-manager/desktop/hyprland/)                           |
| **Filesystem**           |       [Btrfs](https://btrfs.readthedocs.io) with [Impermanence](common/impermanence.nix)       |
| **Bar**                  |                             [Waybar](home-manager/desktop/waybar/)                             |
| **Application Launcher** |                               [Rofi](home-manager/desktop/rofi/)                               |
| **File Manager**         |                             [Nautilus](nixos/desktop/packages.nix)                             |
| **Browser**              |                          [LibreWolf](home-manager/desktop/librewolf/)                          |
| **Text Editor**          | [VSCodium](home-manager/desktop/vscodium/) / [NvF](https://github.com/Vanadium5000/nvf-neovim) |
| **Terminal Emulator**    |                          [Ghostty](home-manager/desktop/ghostty.nix)                           |
| **Shell**                |                          [Fish](home-manager/terminal/shell/fish.nix)                          |
| **Local AI Tools**       |               [LocalAI](https://localai.io) / [Ollama](nixos/desktop/ollama.nix)               |
| **Password Manager**     |    [pass](home-manager/terminal/pass/) with [git-sync](home-manager/terminal/git-sync.nix)     |
| **Login Manager**        |                             [tuigreet](nixos/desktop/tuigreet.nix)                             |

## ✨ Features

- A riced NixOS/Hyprland setup with a somewhat consistent theme
- BTRFS Impermanence with snapshots of old roots stored in /old_roots
- Rofi scripts & packages including: powermenu, askpass, screenshot, rofi-wallpaper
- [Safeeyes](https://slgobinath.github.io/SafeEyes/) to greatly improve healthiness when spending hours using the computer
- Local AIs using Ollama for LLMs & [LocalAI](https://localai.io/) via Podman for many other AIs (with Nvidia CUDA support)
- Security such as encrypted DNS with ResolveD, Impermanence, Firewall, installing many apps as flatpaks, etc.
- Hyprshade which automatically enables blue-light-filter from 19:00 and greyscale from 22:15
- Waybar with a skeumorphic design inspired by [this](https://github.com/diinki/diinki-aero/blob/main/config/waybar/style.css) as well as displaying system information & song lyrics
- Many apps such as Spicetify, Obsidian, Librewolf, VSCodium with complex settings & all adhering to my Stylix theme
- Stylix theming (with Base16) with mainly GTK applications
- Utilises my complete NVF (Neovim) config as a package from another repo
- Automatic syncing of passwords (uses password-store) over multiple devices via [git-sync](home-manages/terminal/git-sync.nix)
- Persisted syncthing config for syncing of large data files like media over multiple devices

## 📋 Important Commands

### Run LocalAI

Note: `--cdi-spec-dir=/run/cdi` is added from the official command to solve this [issue](https://github.com/nixos/nixpkgs/issues/420638)

```bash
docker run -ti --name local-ai -p 8080:8080 --cdi-spec-dir=/run/cdi --gpus all localai/localai:latest-gpu-nvidia-cuda-12
```

<!-- Links -->

[Hyprland]: https://github.com/hyprwm/Hyprland
[Ghostty]: https://ghostty.org/
[powerlevel10k]: https://github.com/romkatv/powerlevel10k
[Waybar]: https://github.com/Alexays/Waybar
[rofi]: https://github.com/lbonn/rofi
[Btop]: https://github.com/aristocratos/btop
[Resources]: https://welcome.gnome.org/app/Resources/
[Nautilus]: https://apps.gnome.org/Nautilus/
[yazi]: https://github.com/sxyazi/yazi
[Fish]: https://fishshell.com/
[Swaylock-effects]: https://github.com/mortie/swaylock-effects
[Hyprlock]: https://github.com/hyprwm/hyprlock
[audacious]: https://audacious-media-player.org/
[mpv]: https://github.com/mpv-player/mpv
[VSCodium]: https://vscodium.com/
[Neovim]: https://github.com/neovim/neovim
[grimblast]: https://github.com/hyprwm/contrib
[imv]: https://sr.ht/~exec64/imv/
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[JetBrainsMono]: https://www.jetbrains.com/lp/mono/
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clipboard]: https://github.com/bugaevc/wl-clipboard
[wf-recorder]: https://github.com/ammen99/wf-recorder
[hyprpicker]: https://github.com/hyprwm/hyprpicker
[Gruvbox]: https://github.com/morhetz/gruvbox
[Papirus-Dark]: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[Bibata-Modern-Ice]: https://www.gnome-look.org/p/1197198
[maxfetch]: https://github.com/jobcmax/maxfetch
[Adwaita gtk theme]: https://gnome.pages.gitlab.gnome.org/libadwaita/
[OBS]: https://obsproject.com/
