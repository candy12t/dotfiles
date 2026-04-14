{ inputs, ... }:
{
  system = {
    stateVersion = 6;
    configurationRevision = inputs.rev or inputs.dirtyRev or null;

    defaults = {
      NSGlobalDomain = {
        AppleEnableMouseSwipeNavigateWithScrolls = true;
        AppleEnableSwipeNavigateWithScrolls = true;
        AppleInterfaceStyle = "Dark";
        KeyRepeat = 2;
      };

      dock = {
        autohide = true;
        autohide-delay = 0.0;
        launchanim = false;
        mru-spaces = false;
        orientation = "bottom";
        show-process-indicators = true;
        show-recents = false;
        tilesize = 50;
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = true;
        ShowPathbar = true;
        ShowStatusBar = true;
        _FXSortFoldersFirst = true;
      };

      screencapture = {
        disable-shadow = true;
      };

      trackpad = {
        ActuateDetents = true;
        Clicking = false;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
        TrackpadPinch = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerHorizSwipeGesture = 2;
        TrackpadThreeFingerVertSwipeGesture = 2;
        TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  time = {
    timeZone = "Asia/Tokyo";
  };

  nix = {
    enable = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      keep-build-log = true;
      keep-derivations = false;
      keep-outputs = false;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
  };

  homebrew = {
    enable = true;
    enableZshIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };

    casks = [
      "1password"
      "blu-ray-player"
      "brave-browser"
      "chatgpt"
      "claude"
      "cmd-eikana"
      "discord"
      "google-chrome"
      "iterm2"
      "slack"
      "visual-studio-code"
    ];
  };
}
