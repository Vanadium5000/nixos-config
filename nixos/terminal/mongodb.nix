{ ... }:
{
  services.mongodb.enable = true;

  # Custom option
  allowedUnfree = [
    "mongodb"
  ];
}
