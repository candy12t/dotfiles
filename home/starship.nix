{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
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

      # env_var.STATUSLINE_* は claude-statusline ラッパー（home/claude.nix）が設定する。Claude Code が子プロセスに CLAUDE_EFFORT を渡すため CLAUDE_ 接頭辞は避ける
      profiles.claude-code = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$claude_model"
        "\${env_var.STATUSLINE_EFFORT}"
        "$claude_context"
        "\${env_var.STATUSLINE_5H_OK}"
        "\${env_var.STATUSLINE_5H_WARN}"
        "\${env_var.STATUSLINE_5H_CRIT}"
      ];
      claude_model.symbol = "";
      claude_context = {
        format = "[$gauge $percentage \\($input_tokens/$total_tokens\\)]($style) ";
        display = [
          {
            threshold = 0.0;
            style = "bold green";
          }
          {
            threshold = 50.0;
            style = "bold yellow";
          }
          {
            threshold = 80.0;
            style = "bold red";
          }
        ];
      };
      env_var = {
        STATUSLINE_EFFORT = {
          format = "[\\($env_value\\)]($style) ";
          style = "bold blue";
        };
        STATUSLINE_5H_OK = {
          format = "[5h $env_value]($style) ";
          style = "bold green";
        };
        STATUSLINE_5H_WARN = {
          format = "[5h $env_value]($style) ";
          style = "bold yellow";
        };
        STATUSLINE_5H_CRIT = {
          format = "[5h $env_value]($style) ";
          style = "bold red";
        };
      };
    };
  };
}
