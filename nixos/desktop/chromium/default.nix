{ pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    brave
  ];

  programs.chromium = {
    enable = true;

    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
      "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
      "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
    ];
    extraOpts = {
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
      "BuiltInDnsClientEnabled" = false;
      "DeviceMetricsReportingEnabled" = false;
      "ReportDeviceCrashReportInfo" = false;
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "en-US"
      ];
      "VoiceInteractionHotwordEnabled" = false;
    };
  };
}
