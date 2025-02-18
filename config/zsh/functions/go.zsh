gmi() {
  if [ $(command -v ghq) ]; then
    local mod_name=$(pwd | sed "s|$(ghq root)/||g")
    go mod init "${mod_name}"
  else
    echo "not install \`ghq\`"
  fi
}

gtc() {
  go test $1 -coverprofile=cover.out
  go tool cover -html=cover.out
  rm -rf cover.out
}
