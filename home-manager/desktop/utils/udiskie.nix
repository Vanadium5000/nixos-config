# Udiskie is a simple daemon that uses udisks to automatically mount removable storage devices.
_: {
  services.udiskie = {
    enable = true;
    notify = true;
    automount = true;
  };
}
