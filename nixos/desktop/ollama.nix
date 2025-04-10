_: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
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
