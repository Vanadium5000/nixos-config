{
  config,
  pkgs,
  ...
}:
{
  home = {
    # Use centralized cargo cache
    sessionVariables = rec {
      CARGO_HOME = "${config.xdg.dataHome}/.cargo";
      CARGO_TARGET_DIR = "${CARGO_HOME}/target";
      RUSTUP_HOME = "${config.xdg.dataHome}/.rustup";
    };

    # Add cargo binaries to path
    sessionPath = [ ".local/share/.cargo/bin" ];
  };

  # Add the custom completions for both fish and fish
  programs = {
    fish.functions = {
      __cargo_bins = ''cargo run --bin 2>&1 | string replace -rf '^\s+' ""'';
    };
    bash.initExtra = ''
      __cargo_bins() {
        local bins
        bins=$(cargo run --bin 2>&1 | sed 's/^\s\+//')
        COMPREPLY=("''${bins}")
      }
    '';
  };

  home.packages =
    with pkgs;
    (
      # Rust packages
      [
        rustup # Rust toolchain installer
      ]
      # Random libraries, often used by cargo
      ++ [
        openssl
        ncurses
        pkg-config
      ]
    );

  customPersist.home.directories = [
    ".local/share/.cargo"
    ".local/share/.rustup"
  ];
}
