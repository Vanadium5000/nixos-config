{ config, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = if config.nixpkgs.config.cudaSupport then "cuda" else false;
  };

  customPersist.nixos.directories = [
    {
      directory = "/var/lib/private/ollama";
      user = "ollama";
      group = "ollama";
      mode = "0700";
    }
  ];
}
