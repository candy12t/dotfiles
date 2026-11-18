{ config, pkgs, ... }:
let
  # Starship は effort とレートリミットの変数を提供しないため、環境変数経由で env_var モジュールに渡す
  claude-statusline = pkgs.writeShellApplication {
    name = "claude-statusline";
    runtimeInputs = [
      pkgs.jq
      config.programs.starship.package
    ];
    text = ''
      input=$(cat)

      # 空フィールドが詰められないよう、区切り文字は IFS 空白文字以外（US: 0x1f）を使う
      IFS=$'\x1f' read -r dir effort pct resets_at < <(
        jq -r '[
          (.workspace.current_dir // .cwd // ""),
          (.effort.level // ""),
          (.rate_limits.five_hour.used_percentage // "" | if . == "" then "" else (. + 0.5 | floor) end),
          (.rate_limits.five_hour.resets_at // "" | if . == "" then "" else floor end)
        ] | map(tostring) | join("\u001f")' <<<"$input"
      ) || true

      # Starship の directory・git モジュールは JSON ではなくプロセスの cwd を参照するため
      if [[ -n "$dir" ]]; then
        cd "$dir" 2>/dev/null || true
      fi

      if [[ -n "$effort" ]]; then
        export STATUSLINE_EFFORT="$effort"
      fi

      # env_var モジュールはスタイルを動的に変更できないため、しきい値ごとに別の変数へ振り分ける
      if [[ -n "$pct" && -n "$resets_at" ]]; then
        remain=$((resets_at - EPOCHSECONDS))
        if ((remain < 60)); then
          left="<1m"
        elif ((remain < 3600)); then
          left="$((remain / 60))m"
        else
          left="$((remain / 3600))h$((remain % 3600 / 60))m"
        fi
        value="''${pct}% ↻''${left}"
        if ((pct >= 80)); then
          export STATUSLINE_5H_CRIT="$value"
        elif ((pct >= 50)); then
          export STATUSLINE_5H_WARN="$value"
        else
          export STATUSLINE_5H_OK="$value"
        fi
      fi

      # グローバル設定の add_newline = true が statusline にも適用されるため
      out=$(starship statusline claude-code <<<"$input")
      printf '%s' "''${out#$'\n'}"
    '';
  };
in
{
  home.packages = [ claude-statusline ];
}
