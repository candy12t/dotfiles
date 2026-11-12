{ ... }:
{
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      extraFlags = [
        "--force-cleanup"
        "--zap"
      ];
    };

    casks = [
      "iterm2"
    ];
  };
}
