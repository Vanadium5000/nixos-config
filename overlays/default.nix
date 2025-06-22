# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = _final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    ueberzugpp = prev.ueberzugpp.override {
      enableOpencv = false;
    };
    rofi-calc = prev.rofi-calc.override {
      rofi-unwrapped = prev.rofi-wayland-unwrapped;
    };
    rofi-vpn = prev.rofi-vpn.override {
      rofi-unwrapped = prev.rofi-wayland-unwrapped;
    };
    lldb = prev.lldb.overrideAttrs {
      dontCheckForBrokenSymlinks = true;
    };
    basedpyright = prev.basedpyright.overrideAttrs {
      dontCheckForBrokenSymlinks = true;
    };
    waydroid = prev.waydroid.override {
      python3Packages = prev.python312Packages;
    };
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = false;
    };
  };

  # When applied, the stable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = false;
    };
  };
  # Adds Nix User Repository: User contributed nix packages, under 'pkgs.nur'
  nur-packages = final: _prev: {
    nur = inputs.nur.overlays.default;
  };
}
