{ config, lib, ... }:

let
  inherit (lib) mkIf;
  mkIfCaskPresent = cask: mkIf (lib.any (x: x == cask) config.homebrew.casks);
  brewEnabled = config.homebrew.enable;
in

{
  environment.shellInit = mkIf brewEnabled ''
    eval "$(${config.homebrew.brewPrefix}/brew shellenv)"
  '';

  # https://docs.brew.sh/Shell-Completion#configuring-completions-in-fish
  # For some reason if the Fish completions are added at the end of `fish_complete_path` they don't
  # seem to work, but they do work if added at the start.
  programs.fish.interactiveShellInit = mkIf brewEnabled ''
    if test -d (brew --prefix)"/share/fish/completions"
      set -p fish_complete_path (brew --prefix)/share/fish/completions
    end

    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
  '';


homebrew = {
    enable = true;
    onActivation = {
        autoUpdate = true;
        cleanup = "uninstall";
        upgrade = true;
    };
};


  homebrew.taps = [
#    "homebrew/cask"
#    "homebrew/cask-drivers"
#    "homebrew/cask-fonts"
#    "homebrew/cask-versions"
#    "homebrew/core"
#    "homebrew/services"
    "nrlquaker/createzap"
    "facebook/fb"
    "mobile-dev-inc/tap"
    "mac-cleanup/mac-cleanup-py"
    "oven-sh/bun"
    # "PlayCover/playcover"
  ];

  # Prefer installing application from the Mac App Store
  #
  # Commented apps suffer continual update issue:
  # https://github.com/malob/nixpkgs/issues/9
  homebrew.masApps = {
    # "1Blocker" = 1365531024;
    # "1Password" = 1333542190;
    # "1Password for Safari" = 1569813296;
    # "Accelerate for Safari" = 1459809092;
    # "Apple Configurator 2" = 1037126344;
    # DaisyDisk = 411643860;
    # "Dark Mode for Safari" = 1397180934;
    # Deliveries = 290986013;
    # Fantastical = 975937182;
    # "Gemini 2" = 1090488118;
    # "iMazing Profile Editor" = 1487860882;
    # Keynote = 409183694;
    # "LG Screen Manager" = 1142051783;
    # MindNode = 1289197285;
    # Numbers = 409203825;
    # Pages = 409201541;
    # Patterns = 429449079;
    # Patterns = 429449079;
    # "Pixelmator Classic" = 407963104;
    # "Pixelmator Pro" = 1289583905;
    # "Save to Raindrop.io" = 1549370672;
    # Slack = 803453959;
    # SiteSucker = 442168834;
    # "Things 3" = 904280696;
    # TripMode = 1513400665;
    # Ulysses = 1225570693;
    # Vimari = 1480933944;
    # "WiFi Explorer" = 494803304;
    # Xcode = 497799835;
    # "Yubico Authenticator" = 1497506650;
#    Amphetamine = 937984704;
    ColorSlurp = 1287239339;
    Spark = 6445813049;
#    "SpeakerAmp:Booster & Equalizer" = 1496955576;
#    Guidance = 412759995;
#    Fresco = 1251572132;
#    Boom3D = 1233048948;
#    BalanceLock = 1019371109;

  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
#    "alt-tab"
    "ghostty"
    "airbuddy"
    "arc"
    "aldente"
#    "appcleaner"
    "bartender" # enable it later
    "blender"
    "discord"
    "betterdiscord-installer"
#    "cheatsheet"
    "copilot-for-xcode"
    "dbeaver-community"
#    "beekeeper-studio"
#    "keycastr"
#    "docker"
#    "dozer"
    "obsidian"
    #"fig"
    "figma"
    "free-download-manager"
    "font-monaspace"
    # "google-chrome"
    "grammarly-desktop"
    "iina"
    "jetbrains-toolbox"
    "istat-menus"
    "iterm2"
    "logi-options+"
    "localsend"
    "karabiner-elements"
    "keka"
#    "meld"
    "mos"
    "MonitorControl"
#    "notchnook"
    #"notion"
#    "intellidock" # disable until this fixed
    "orbstack"
    "postman"
    "pearcleaner"
    # "playcover-nightly"
    "rectangle"
    # "insomnia"
#    "telegram"
    "raycast"
    # "upwork" issue install from homebrew
#    "visual-studio-code"
#    "whatsapp"
    "obs"
    #"whisky"
  ];

  # Configuration related to casks
  #environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "1password-cli"
  #  "/Users/${config.users.primaryUser.username}/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
  homebrew.brews = [
    "swift-format"
    "swiftlint"
    "cocoapods"
    "yt-dlp"
    "fontforge"
    "pkg-config"
    "fprobe"
    "gh"
    "pipx"
    "gnupg"
    "ffmpeg"
    "fastfetch"
    "maven"
    "maestro"
    "idb-companion"
    "neovim"
    "scrcpy"
    "pinentry-mac"
    "bun"
    "node"
    "yarn"
    "mtr"
    "mac-cleanup-py"
    "libpq" # execute this: brew link --force libpq
    "lcov"
  ];
}
