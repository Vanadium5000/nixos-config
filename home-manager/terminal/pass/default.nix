{pkgs, ...}: {
  # Password management CLI, can be used with rofi, browser extensions, etc.
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-otp # OTP support
    ]);
  };
}
