{ pkgs, tokyonightSrc, ... }:
let
  guid = "nix-default";

  statusBarLayout = {
    "advanced configuration" = {
      algorithm = 0;
      "auto-rainbow style" = 0;
      font = ".AppleSystemUIFont 12";
    };
    components = [
      {
        class = "iTermStatusBarBatteryComponent";
        configuration = {
          knobs = {
            "base: compression resistance" = 1;
            "base: priority" = 5.0;
            "shared text color" = {
              "Alpha Component" = 1.0;
              "Blue Component" = 0.63;
              "Color Space" = "sRGB";
              "Green Component" = 0.63;
              "Red Component" = 0.9;
            };
          };
          "layout advanced configuration dictionary value" = {
            algorithm = 0;
            font = ".AppleSystemUIFont 12";
          };
        };
      }
      {
        class = "iTermStatusBarCPUUtilizationComponent";
        configuration = {
          knobs = {
            "base: compression resistance" = 1;
            "base: priority" = 5.0;
            "shared text color" = {
              "Alpha Component" = 1.0;
              "Blue Component" = 0.63;
              "Color Space" = "sRGB";
              "Green Component" = 0.9;
              "Red Component" = 0.765;
            };
          };
          "layout advanced configuration dictionary value" = {
            algorithm = 0;
            font = ".AppleSystemUIFont 12";
          };
        };
      }
      {
        class = "iTermStatusBarMemoryUtilizationComponent";
        configuration = {
          knobs = {
            "base: compression resistance" = 1;
            "base: priority" = 5.0;
            "shared text color" = {
              "Alpha Component" = 1.0;
              "Blue Component" = 0.9;
              "Color Space" = "sRGB";
              "Green Component" = 0.9;
              "Red Component" = 0.63;
            };
          };
          "layout advanced configuration dictionary value" = {
            algorithm = 0;
            font = ".AppleSystemUIFont 12";
          };
        };
      }
      {
        class = "iTermStatusBarNetworkUtilizationComponent";
        configuration = {
          knobs = {
            "base: compression resistance" = 1;
            "base: priority" = 5.0;
          };
          "layout advanced configuration dictionary value" = {
            algorithm = 0;
            "auto-rainbow style" = 0;
          };
        };
      }
      {
        class = "iTermStatusBarClockComponent";
        configuration = {
          knobs = {
            "base: compression resistance" = 1;
            "base: priority" = 5.0;
            format = "M/dd h:mm";
          };
          "layout advanced configuration dictionary value" = {
            algorithm = 0;
            "auto-rainbow style" = 0;
          };
        };
      }
    ];
  };

  profile = {
    Name = "Nix";
    Guid = guid;

    # フォント
    "Normal Font" = "HackGenConsoleNF-Regular 16";
    "Draw Powerline Glyphs" = true;

    # ウィンドウ
    Transparency = 0.1;
    "Only The Default BG Color Uses Transparency" = true;

    # キー・挙動
    "Option Key Sends" = 2; # 左 Option を Esc+ として送る
    "Silence Bell" = true;
    "Prompt Before Closing 2" = false;

    # ステータスバー
    "Show Status Bar" = true;
    "Status Bar Layout" = statusBarLayout;
  };

  mergeScript = pkgs.writeText "merge-iterm2-profile.py" ''
    import json, os, plistlib
    with open(os.environ["colorsPath"], "rb") as f:
        colors = plistlib.load(f)
    with open(os.environ["profilePath"]) as f:
        profile = json.load(f)
    with open(os.environ["out"], "w") as f:
        json.dump({"Profiles": [colors | profile]}, f, indent=2)
  '';
  dynamicProfile = pkgs.runCommand "iterm2-dynamic-profile.json" {
    nativeBuildInputs = [ pkgs.python3 ];
    colorsPath = "${tokyonightSrc}/extras/iterm/tokyonight_moon.itermcolors";
    profilePath = pkgs.writeText "iterm2-profile.json" (builtins.toJSON profile);
  } "python3 ${mergeScript}";
in
{
  home.file."Library/Application Support/iTerm2/DynamicProfiles/nix.json".source = dynamicProfile;

  targets.darwin.defaults."com.googlecode.iterm2" = {
    "Default Bookmark Guid" = guid;

    # ホットキー（Ctrl + Space で iTerm2 を表示）
    Hotkey = true;
    HotkeyChar = 32;
    HotkeyCode = 49;
    HotkeyModifiers = 262401;
    HotkeyMigratedFromSingleToMulti = true;

    # 外観
    TabStyleWithAutomaticOption = 5; # Minimal
    UseLionStyleFullscreen = false;
  };
}
