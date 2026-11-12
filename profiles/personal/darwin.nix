{ hostName, ... }:
{
  networking = {
    computerName = hostName;
    hostName = hostName;

    applicationFirewall = {
      enable = true;
      enableStealthMode = true;
      allowSigned = true;
      allowSignedApp = true;
      blockAllIncoming = false;
    };
  };

  homebrew.casks = [
    "1password"
    "blu-ray-player"
    "brave-browser"
    "discord"
    "slack"
  ];
}
