{ ... }:
{
  security.pki.certificateFiles = [ ../../certs/CatoNetworksTrustedRootCA.pem ];

  homebrew.casks = [
    "claude"
    "gather"
    "google-japanese-ime"
    "windows-app"
  ];
}
