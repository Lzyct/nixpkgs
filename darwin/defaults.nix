{
  system.defaults.NSGlobalDomain = {
    # Disable system theme
    AppleInterfaceStyleSwitchesAutomatically = false;
    AppleMeasurementUnits = "Centimeters";
    AppleMetricUnits = 1;
    AppleShowScrollBars = "Automatic";
    AppleTemperatureUnit = "Celsius";
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
    _HIHideMenuBar = false;
    AppleShowAllExtensions = true;
    AppleFontSmoothing = 0;
    AppleICUForce24HourTime=false;
  };

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

  ## copy to clipboard when screen capture
  system.defaults.screencapture.target = "clipboard";

  system.defaults.menuExtraClock = {
    IsAnalog = true;
    Show24Hour= false;
    ShowAMPM = true;
  };


  # Dock and Mission Control
  system.defaults.dock = {
    autohide = true;
    expose-group-apps = false;
    mru-spaces = false;
    tilesize = 38;
    # Disable all hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
    autohide-delay = 0.0;
    orientation = "right";
    persistent-apps = [
      "/System/Applications/iPhone Mirroring.app"
      ];
  };

  # Login and lock screen
  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
  };

  # Spaces
  system.defaults.spaces.spans-displays = false;

  # Trackpad
  system.defaults.trackpad = {
    Clicking = false;
    TrackpadRightClick = true;
    # Enable silent click on trackpad
    # 0 to enable Silent Clicking, 1 to disable.  The default is 1.
    ActuationStrength = 1;
  };

  # Finder
  system.defaults.finder = {
    ShowStatusBar = true;
    ShowPathbar = true;
    FXDefaultSearchScope = "SCcf";
    FXPreferredViewStyle = "Nlsv";
    FXRemoveOldTrashItems = true;
    AppleShowAllExtensions = true;
    CreateDesktop = false;
    NewWindowTarget = "Home";
    QuitMenuItem = true;
    _FXShowPosixPathInTitle = false;
    _FXSortFoldersFirst = false;
    _FXSortFoldersFirstOnDesktop = false;
    FXEnableExtensionChangeWarning = false;
    ShowExternalHardDrivesOnDesktop = false;
    ShowHardDrivesOnDesktop = false;
    ShowMountedServersOnDesktop = false;
    ShowRemovableMediaOnDesktop = false;
  };
}
