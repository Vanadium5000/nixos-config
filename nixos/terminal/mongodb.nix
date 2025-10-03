{ ... }:
{
  services.mongodb.enable = true;

  # Custom option
  allowedUnfree = [
    "mongodb"
  ];

  # Persist data
  customPersist.nixos.directories = [
    # "/var/db/" # Meant to be /var/db/mongodb but it breaks mongodb
  ];
}
