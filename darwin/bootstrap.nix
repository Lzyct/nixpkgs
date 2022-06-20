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
  #autosuggestions.enable = true;
  #syntaxHighlighting.enable = true;
  #shellAliases = {
  # ls = "${pkgs.exa}/bin/exa --color=auto --group-directories-first --classify --icons";
  # intel = "arch -x86_64";
  # fixaudio = "sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"; 
   # Nix related
  # drb = "darwin-rebuild build --flake ~/.config/nixpkgs/";
  # drs = "darwin-rebuild switch --flake ~/.config/nixpkgs/";
   # is equivalent to: nix build --recreate-lock-file
  # flakeup = "nix flake update ~/.config/nixpkgs/";
  # nb = "nix build";
  # nd = "nix develop";
  # nf = "nix flake";
  # nr = "nix run";
  # ns = "nix search";
  # };
  #profileExtra = ''
  #    setopt incappendhistory
  #    setopt histfindnodups
  #    setopt histreduceblanks
  #    setopt histverify
  #    setopt correct                                                  # Auto correct mistakes
  #    setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
  #    setopt nocaseglob                                               # Case insensitive globbing
  #    setopt rcexpandparam                                            # Array expension with parameters
  #    #setopt nocheckjobs                                              # Don't warn about running processes when exiting
  #    setopt numericglobsort                                          # Sort filenames numerically when it makes sense
  #    unsetopt nobeep                                                 # Enable beep
  #    setopt appendhistory                                            # Immediately append history instead of overwriting
  #    unsetopt histignorealldups                                      # If a new command is a duplicate, do not remove the older one
  #    setopt interactivecomments
  #    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
  #    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       # Colored completion (different colors for dirs/files/etc)
  #    zstyle ':completion:*' rehash true                              # automatically find new executables in path
      # Speed up completions
  #    zstyle ':completion:*' accept-exact '*(N)'
  #    zstyle ':completion:*' use-cache on
  #    zstyle ':completion:*' menu select
  #    WORDCHARS=''${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
  #  '';
  #history = {
  #    expireDuplicatesFirst = true;
  #    ignoreDups = true;
  #    ignoreSpace = true;
  #    extended = true;
  #    #path = "${config.xdg.dataHome}/zsh/history";
  #    share = true;
  #    size = 100000;
  #    save = 100000;
  #};
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
  #oh-my-zsh = {
  #  enable = true;
  #  plugins = [ "git" "thefuck" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
  #  theme = "dracula";
  #  };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
