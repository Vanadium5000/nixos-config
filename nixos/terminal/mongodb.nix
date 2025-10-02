{ ... }:
{
  services.mongodb.enable = true;

  # Custom option
  allowedUnfree = [
    "mongodb"
  ];

  # Persist data
  customPersist.nixos.directories = [
    "/var/db/mongodb"
  ];
}
