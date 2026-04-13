{ config, tokyonightSrc, ... }:
{
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      file-style = "omit";
      file-decoration-style = "none";
      hunk-header-decoration-style = "blue ul";
      hunk-header-style = "file line-number syntax";
      keep-plus-minus-markers = true;
      line-numbers = true;
      line-numbers-left-format = "{nm:>4} ";
      line-numbers-right-format = "{np:>4}│";
      navigate = true;
      side-by-side = false;
      colorMoved = "default";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      alias = {
        ll = "log --oneline --decorate";
        lg = "log --oneline --all --graph --decorate";
        ss = "status -su";
        cm = "commit -m";
        cv = "commit -v";
        df = "diff";
        co = "checkout";
      };
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
      core = {
        quotepath = false;
        editor = "nvim";
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      push = {
        default = "current";
        autoSetupRemote = true;
      };
      url = {
        "git@github.com:candy12t" = {
          insteadOf = "https://github.com/candy12t";
        };
      };
      ghq = {
        root = config.home.homeDirectory + "/dev";
      };
      credential = {
        "https://github.com" = {
          helper = "!gh auth git-credential";
        };
      };
    };
    includes = [
      {
        path = "${tokyonightSrc}/extras/delta/tokyonight_moon.gitconfig";
      }
    ];
    ignores = [
      ".DS_Store"
      ".claude/*"
    ];
  };
}
