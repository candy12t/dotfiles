{ pkgs, ... }:
{
  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = "${../../certs/CatoNetworksTrustedRootCA.pem}";
  };

  home.packages = with pkgs; [
    envsubst
    gnupg
    javaPackages.compiler.openjdk25
    k6
    plantuml
    python314
    terraform-landscape
    tfenv
    unzip
  ];
}
