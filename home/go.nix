{ config, ... }:
{
  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
    };
  };

  home.sessionPath = [
    "${config.programs.go.env.GOPATH}/bin"
  ];
}
