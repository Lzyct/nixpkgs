{ config, lib, pkgs, ... }:

{
  # Nix configuration ------------------------------------------------------------------------------

  nix.binaryCaches = [
    "https://cache.nixos.org/"
    "https://lzyct.cachix.org"
  ];
  nix.binaryCachePublicKeys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    "lzyct.cachix.org-1:6BG5dYpTFx3sZVULyx/A/F03eXTZnfeL3MFGorx9nx8="
  ];
  nix.trustedUsers = [
    "@admin"
  ];
  users.nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  # nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;


  # Shells -----------------------------------------------------------------------------------------

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  # Make zsh as the default shell
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  interactiveShellInit = ''
   # Set encoding UTF-8
   export LANG=en_US.UTF-8
   # Android
   export ANDROID_HOME=/Users/$USER/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

   # Flutter
   export FLUTTER_HOME=/Users/$USER/Library/flutter/bin
   export PATH=$PATH:$FLUTTER_HOME
   export PATH="$PATH":"$HOME/.pub-cache/bin"
  '';
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
