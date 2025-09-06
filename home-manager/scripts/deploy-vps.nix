# - ## Deploy VPS
#-
#- This module provides a script to SSH into my server & deploy config & website changes.
#-
#- - `deploy-vps` - SSH into my server & deploy config & website changes.
{ pkgs, ... }:
let
  deploy-vps = pkgs.writeShellScriptBin "deploy-vps" ''
    # SSH into the server with a pseudo-terminal
    ssh -t ac@217.154.38.159 << 'EOF'
      # Change to the nixos-config directory
      cd ~/Documents/nixos-config

      # Pull any nixos-config changes
      git pull
      
      # Update specific flake inputs
      nix flake update my-website-frontend
      nix flake update my-website-backend
      
      # Rebuild the system using the flake
      sudo nixos-rebuild switch --flake .
    EOF
  '';
in
{
  # Add the deploy-vps script
  home.packages = [ deploy-vps ];
}
