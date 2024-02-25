#!/bin/bash
#
# skk jisyo installer

set -eu
set -o pipefail

script_home="$(cd $(dirname "$0") && pwd)"
cd "${script_home}"

skk_config_path="$HOME/.config/skk"
skk_jisyo_url="http://openlab.jp/skk/dic/SKK-JISYO.L.gz"

mkdir -p "${skk_config_path}"
curl -fsSL "${skk_jisyo_url}" -o "${skk_config_path}/SKK-JISYO.L.gz"
gzip -d "${skk_config_path}/SKK-JISYO.L.gz"

exit 0;
