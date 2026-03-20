{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "candy12t";
  home.homeDirectory = "/Users/candy12t";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/candy12t/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "tokyonight";
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
      tokyonight = {
        minus-style = "syntax #3a273a";
        minus-non-emph-style = "syntax #3a273a";
        minus-emph-style = "syntax #6b2e43";
        minus-empty-line-marker-style = "syntax #3a273a";
        line-numbers-minus-style = "#b55a67";
        plus-style = "syntax #273849";
        plus-non-emph-style = "syntax #273849";
        plus-emph-style = "syntax #305f6f";
        plus-empty-line-marker-style = "syntax #273849";
        line-numbers-plus-style = "#627259";
        line-numbers-zero-style = "#3b4261";
      };
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
    };
    ignores = [
      ".DS_Store"
      ".claude/*"
    ];
  };
}
