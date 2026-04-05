{ lib, ... }:
{
  programs.starship = {
    enable = true;
    # enableZshIntegration = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$time"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$nix_shell"
        "$line_break"
        "$jobs"
        "$character"
      ];
      command_timeout = 2000;
      time = {
        disabled = false;
        format = lib.concatStrings [
          "[\\[$time\\]]($style) "
        ];
        style = "bold blue";
      };
    };
  };
}
