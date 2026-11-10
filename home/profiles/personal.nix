{ config, ... }:
{
  programs.git.settings = {
    user = {
      name = "Takumi Kanada";
      email = "candy12t@gmail.com";
      signingKey = "${config.home.homeDirectory}/.ssh/id_ed25519_sign.pub";
    };
    gpg = {
      format = "ssh";
      ssh = {
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
    };
    commit = {
      gpgsign = true;
    };
    url = {
      "git@github.com:candy12t" = {
        insteadOf = "https://github.com/candy12t";
      };
    };
  };

  programs.go.env.GOPRIVATE = [
    "github.com/candy12t"
  ];

  programs.zsh.cdpath = [
    "."
    "$HOME"
    "$(ghq root)/github.com/candy12t"
    "$(ghq root)/github.com"
    ".."
  ];
}
