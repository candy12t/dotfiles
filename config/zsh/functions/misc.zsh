daily() {
  today=$(date +%Y%m%d)
  daily="$HOME/tmp/daily/$today"
  mkdir -p "$daily"
  [ ! -e "$daily/daily.md" ] && echo "# $today\n\n## Todo\n\n- [ ] todo1" > "$daily/daily.md"
  nvim "$daily/daily.md"
}

cd_daily() {
  today=$(date +%Y%m%d)
  daily="$HOME/tmp/daily/$today"
  mkdir -p "$daily"
  cd "$daily"
}
