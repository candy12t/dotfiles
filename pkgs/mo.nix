# k1LoW/mo（nixpkgs 未提供のため GitHub Release のビルド済みバイナリを利用）
#
# 更新手順:
#   1. version を書き換える
#   2. nix store prefetch-file https://github.com/k1LoW/mo/releases/download/v<version>/mo_v<version>_darwin_arm64.zip
#   3. 出力された hash で下記 hash を置き換える
{
  lib,
  stdenvNoCC,
  fetchurl,
  unzip,
  installShellFiles,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "mo";
  version = "1.7.0";

  src = fetchurl {
    url = "https://github.com/k1LoW/mo/releases/download/v${finalAttrs.version}/mo_v${finalAttrs.version}_darwin_arm64.zip";
    hash = "sha256-B4ciaqP/mcyFxIP1EsKa/YiTWSdsoQhBs6FHyZabN0Y=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [
    unzip
    installShellFiles
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 mo $out/bin/mo
    installShellCompletion --cmd mo --zsh <($out/bin/mo completion zsh)

    runHook postInstall
  '';

  meta = {
    description = "Markdown viewer that opens .md files in a browser";
    homepage = "https://github.com/k1LoW/mo";
    license = lib.licenses.mit;
    mainProgram = "mo";
    platforms = [ "aarch64-darwin" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
