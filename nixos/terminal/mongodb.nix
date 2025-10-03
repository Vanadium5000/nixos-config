{ ... }:
{
  services.mongodb.enable = true;

  # Custom option
  allowedUnfree = [
    "mongodb"
  ];

  # Persist data
  customPersist.nixos.directories = [
    {
      directory = "/var/db/mongodb";
      user = "mongodb";
      group = "mongodb";
      mode = "0700";
    }
  ];
}
