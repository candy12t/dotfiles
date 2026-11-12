{ pkgs, ... }:
{
  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = "${./CatoNetworksTrustedRootCA.pem}";
  };

  home.packages = with pkgs; [
    awscli2
    aws-sam-cli
    envsubst
    gnupg
    javaPackages.compiler.openjdk25
    k6
    plantuml
    python314
    ssm-session-manager-plugin
    terraform-landscape
    tfenv
  ];
}
