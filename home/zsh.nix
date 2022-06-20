{ config, lib, pkgs, ... }:

{
# Enable zsh
 programs.zsh = {
  enable = true;
  autocd = true;
  enableCompletion = true;
  enableAutosuggestions = true;
  enableSyntaxHighlighting = true;

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
   setopt BANG_HIST                 # Treat the '!' character specially during expansion.
   setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
   setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
   setopt SHARE_HISTORY             # Share history between all sessions.
   setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
   setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
   setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
   setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
   setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
   setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
   setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
   setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
   setopt HIST_BEEP                 # Beep when accessing nonexistent history.
   '';
   initExtra = ''
   bindkey '^[[A' up-line-or-search # up key
   bindkey '^[[B' down-line-or-search # down key
   '';
   envExtra = ''

   # Set encoding UTF-8
   export LC_ALL=en_US.UTF-8
   export LANG=en_US.UTF-8

   # Android
   export ANDROID_HOME=/Users/$USER/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

   # Flutter
   export FLUTTER_HOME=/Users/$USER/Library/flutter/bin
   export PATH=$PATH:$FLUTTER_HOME
   export PATH="$PATH":"$HOME/.pub-cache/bin"
   '';
   history = {
     size = 10000000;
     save = 10000000;
   };

   zplug = {
      enable = true;
      plugins = [
      {
        name = "dracula/zsh";
        tags = [ "as:theme" "depth:1" ];
      }
      {
         name = "zsh-users/zsh-autosuggestions";
      }
      {
         name = "zsh-users/zsh-syntax-highlighting";
      }
      {
         name = "zsh-users/zsh-completions";
      }

      ];
    };
 };
}
