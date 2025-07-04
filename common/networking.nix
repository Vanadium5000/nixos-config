{
  config,
  options,
  pkgs,
  ...
}:
{
  networking = {
    hostName = config.var.hostname;

    # CLI/TUI for connecting to networks
    networkmanager = {
      enable = true;
      # Prevents networkmanager override set nameservers
      #dns = "none";
    };

    # Better security
    firewall.enable = true;

    # Use custom DNS
    nameservers = [
      "1.1.1.1#cloudflare-dns.com" # Cloudflare
      "1.0.0.1#cloudflare-dns.com" # Cloudflare
      "9.9.9.10#dns10.quad9.net" # Quad9 + no "threat" blocking
    ];

    # NTP servers - https://wiki.nixos.org/wiki/NTP
    timeServers =
      options.networking.timeServers.default
      # https://developers.cloudflare.com/time-services/ntp/usage/
      ++ [
        "162.159.200.1"
        "162.159.200.123"
      ];
  };

  # DNS encryption over tls
  # Troubleshooting Tool:
  #  resolvectl status
  #  resolvectl query <hostname>
  services.resolved = {
    enable = true;

    dnssec = "allow-downgrade"; # "true" | "allow-downgrade" | "false"
    dnsovertls = "opportunistic"; # "true" | "opportunistic" | "false"
    domains = [ "~." ]; # "use as default interface for all requests"

    # (see man resolved.conf)
    # let Avahi handle mDNS publication
    extraConfig = ''
      MulticastDNS=resolve
    '';

    llmnr = "true"; # full LLMNR responder and resolver support
  };

  # Local device discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # NTP and NTS client and server implementation
  services.chrony.enable = true;
}
