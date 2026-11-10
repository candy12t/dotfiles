{ config, ... }:
{
  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
    };
  };

  home.sessionPath = [
    "$(go env GOPATH)/bin"
  ];
}
