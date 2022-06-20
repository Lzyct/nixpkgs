{ config, lib, pkgs, ... }:

{
# Enable zsh
 programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
   ls = "${pkgs.exa}/bin/exa --color=auto --group-directories-first --classify --icons";
   intel = "arch -x86_64";
   fixaudio = "sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod"; 
   # Nix related
   drb = "darwin-rebuild build --flake ~/.config/nixpkgs/";
   drs = "darwin-rebuild switch --flake ~/.config/nixpkgs/";
   # is equivalent to: nix build --recreate-lock-file
   flakeup = "nix flake update ~/.config/nixpkgs/";
   nb = "nix build";
   nd = "nix develop";
   nf = "nix flake";
   nr = "nix run";
   ns = "nix search";
   };
  profileExtra = ''
      setopt incappendhistory
      setopt histfindnodups
      setopt histreduceblanks
      setopt histverify
      setopt correct                                                  # Auto correct mistakes
      setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
      setopt nocaseglob                                               # Case insensitive globbing
      setopt rcexpandparam                                            # Array expension with parameters
      #setopt nocheckjobs                                              # Don't warn about running processes when exiting
      setopt numericglobsort                                          # Sort filenames numerically when it makes sense
      unsetopt nobeep                                                 # Enable beep
      setopt appendhistory                                            # Immediately append history instead of overwriting
      unsetopt histignorealldups                                      # If a new command is a duplicate, do not remove the older one
      setopt interactivecomments
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"       # Colored completion (different colors for dirs/files/etc)
      zstyle ':completion:*' rehash true                              # automatically find new executables in path
      # Speed up completions
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' menu select
      WORDCHARS=''${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
    '';
  history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
      share = true;
      size = 100000;
      save = 100000;
  };
  oh-my-zsh = {
   enable = true;
   plugins = [ "git" "thefuck" "zsh-autosuggestions" "zsh-syntax-highlighting" ];
   theme = "dracula";
   };
 };
}
