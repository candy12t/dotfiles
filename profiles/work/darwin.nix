{ ... }:
{
  security.pki.certificateFiles = [ ./CatoNetworksTrustedRootCA.pem ];

  homebrew.casks = [
    "claude"
    "gather"
    "google-japanese-ime"
    "windows-app"
  ];
}
