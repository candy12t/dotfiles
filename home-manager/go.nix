{ config, ... }:
{
  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOPRIVATE = [
        "github.com/candy12t"
      ];
    };
  };
}
