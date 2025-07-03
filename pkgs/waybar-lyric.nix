{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule {
  pname = "waybar-lyric";
  version = "unstable-2025-07-03";

  src = fetchFromGitHub {
    owner = "Nadim147c";
    repo = "waybar-lyric";
    rev = "c1415e9191a3afa9898670d97adea2755de8874d"; # Use a specific tag like "v0.1.0" or commit hash
    sha256 = "sha256-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX="; # Replace with actual hash
  };

  # Vendor hash for Go dependencies
  vendorSha256 = "sha256-YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY="; # Replace with actual hash

  # Optional: Specify submodules if the repository uses them
  # fetchSubmodules = true;

  # Metadata for the package
  meta = with lib; {
    description = "A Waybar module for displaying song lyrics";
    homepage = "https://github.com/Nadim147c/waybar-lyric";
    license = licenses.mit; # Adjust based on the actual license
    maintainers = with maintainers; []; # Add your name or leave empty
    platforms = platforms.linux; # Adjust if needed
  };
}
