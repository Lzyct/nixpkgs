{
  system.defaults.NSGlobalDomain = {
    "com.apple.trackpad.scaling" = 2.9;
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

  system.defaults.menuExtraClock = {
    IsAnalog = true;
    Show24Hour= false;
    ShowAMPM = true;
  };

  # Firewall
  system.defaults.alf = {
    globalstate = 1;
    allowsignedenabled = 1;
    allowdownloadsignedenabled = 1;
    stealthenabled = 1;
  };

  # Dock and Mission Control
  system.defaults.dock = {
    autohide = false;
    expose-group-by-app = false;
    mru-spaces = false;
    tilesize = 28;
    # Disable all hot corners
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 1;
    wvous-tr-corner = 1;
    autohide-delay = 0.0;
    orientation = "left";
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
    ActuationStrength = 0;
  };

  # Finder
  system.defaults.finder = {
    FXEnableExtensionChangeWarning = true;
    AppleShowAllExtensions = true;
    ShowStatusBar = true;
    ShowPathbar = true;
  };
}

