{ config, pkgs, lib, ... }:

{
  # Fish Shell (Default shell)
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.fish.enable
  programs.fish.enable = true;

  # Fish plugins
  # See:
  # https://github.com/NixOS/nixpkgs/tree/90e20fc4559d57d33c302a6a1dce545b5b2a2a22/pkgs/shells/fish/plugins
  # for list available plugins built-in nixpkgs
  home.packages = [
    # https://github.com/franciscolourenco/done
    pkgs.fishPlugins.done
    # use babelfish than foreign-env
    pkgs.fishPlugins.foreign-env
    # https://github.com/wfxr/forgit
    pkgs.fishPlugins.forgit
    #  fzf.fizh fail
    # https://github.com/PatrickF1/fzf.fish
  ];


  programs.fish.plugins = [
    {
      name = "autopair";
      src = pkgs.fetchFromGitHub {
        owner = "jorgebucaran";
        repo = "autopair.fish";
        rev = "1222311994a0730e53d8e922a759eeda815fcb62";
        sha256 = "0lxfy17r087q1lhaz5rivnklb74ky448llniagkz8fy393d8k9cp";
      };
    }
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
        sha256 = "069ybzdj29s320wzdyxqjhmpm9ir5815yx6n522adav0z2nz8vs4";
      };
    }
  ];

 programs.fish.shellInit = ''
     set -x LC_ALL en_US.UTF-8
     set -x LANG en_US.UTF-8

     # Android
     set -x ANDROID_HOME /Users/$USER/Library/Android/sdk
     set -x PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

     # Flutter
     set -x FLUTTER_HOME /Users/$USER/Library/flutter/bin
     set -x PATH $PATH:$FLUTTER_HOME
     set -x PATH "$PATH":"$HOME/.pub-cache/bin"
     set fish_greeting
  '';

  programs.fish.functions = {
    gitignore = "curl -sL https://www.gitignore.io/api/$argv";
  };

  # Fish abbreviations
  programs.fish.shellAbbrs = { };

  # Fish alias : register alias command in fish
  programs.fish.shellAliases = {
    ls = "${pkgs.exa}/bin/exa --color=auto --group-directories-first --classify --icons";
    intel = "arch -x86_64";
    fixaudio = "sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod";
    # Nix related
    drb = "darwin-rebuild build --flake ~/.config/nixpkgs/";
    drs = "darwin-rebuild switch --flake ~/.config/nixpkgs/";
    fbr = "flutter pub run build_runner build --delete-conflicting-outputs";
  };
}
