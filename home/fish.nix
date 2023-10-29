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

     # Rust
     set -gx PATH "$HOME/.cargo/bin" $PATH

     # Maestro
     set -x PATH $PATH $HOME/.maestro/bin

     # Android
     set -x ANDROID_HOME /Users/$USER/Library/Android/sdk
     set -x PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

     # IntelliJ IDEA
     set -gx PATH "$HOME/.local/bin" $PATH


     # Flutter
     set -x FLUTTER_HOME $HOME/Library/flutter/bin
     set -x PATH $PATH:$FLUTTER_HOME
     set -x PATH "$PATH":"$HOME/.pub-cache/bin"
     
     # IntelliJ idea
     set -x INTELLIJ_IDEA "/Applications/IntelliJ IDEA CE.app/Contents/MacOS"
     set -x PATH $PATH:$INTELLIJ_IDEA

     # Init starship
     eval "$(starship init fish)"

     set fish_greeting
  '';

  programs.fish.functions = {
    gitignore = "curl -sL https://www.gitignore.io/api/$argv";
    fbuild = {
      body = ''
        set flavor $argv[1]
        flutter clean;
        flutter pub get;
        flutter build ipa --flavor $flavor --dart-define-from-file .env.$flavor.json;
        flutter build appbundle --flavor $flavor --dart-define-from-file .env.$flavor.json;
        flutter build apk --flavor $flavor --dart-define-from-file .env.$flavor.json;
        ''
        ;
    };
    fbuild-apk = {
          body = ''
            set flavor $argv[1]
            flutter clean;
            flutter pub get;
            flutter build apk --flavor $flavor --dart-define-from-file .env.$flavor.json;
            ''
            ;
        };
    fbuild-aab = {
          body = ''
            set flavor $argv[1]
            flutter clean;
            flutter pub get;
            flutter build appbundle --flavor $flavor --dart-define-from-file .env.$flavor.json;
            ''
            ;
        };
    fbuild-ipa = {
           body = ''
             set flavor $argv[1]
             flutter clean;
             flutter pub get;
             flutter build ipa --flavor $flavor --dart-define-from-file .env.$flavor.json;
             ''
             ;
         };
    ytd = '' yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality best "$argv[1]" '';
    ytd-pl ='' yt-dlp --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality best --yes-playlist "$argv[1]"'';
    fbuild-old = {
      body = "
        flutter clean;
        flutter pub get;
        flutter build ipa --flavor $argv -t lib/main_$argv.dart --release;
        flutter build appbundle --flavor $argv -t lib/main_$argv.dart --release;
        flutter build apk --flavor $argv -t lib/main_$argv.dart --release;";
    };
    font-nerd-patch = "docker run --rm -v $PWD/ttf:/in -v $PWD/ttf:/out nerdfonts/patcher --complete";
    free = {
       body = ''
        if test (uname) = "Darwin"
    		# Use vm_stat and sysctl to get system info
    		set vmstat (vm_stat | string match -r "[0-9]+")

    		# "Pages free:"
    		set pfree $vmstat[2]
    		# "Pages wired down:"
    		set pwired $vmstat[7]
    		# "Pages inactive:"
    		set pinact $vmstat[4]
    		# "Anonymous pages:"
    		set panon $vmstat[15]
    		# "Pages occupied by compressor:"
    		set pcomp $vmstat[17]
    		# "Pages purgeable:"
    		set ppurge $vmstat[8]
    		# "File-backed pages:"
    		set pfback $vmstat[14]

    		set total_mem (sysctl -n hw.memsize)

    		# Arithmetics
    		set total_mem (math "$total_mem / 1024 / 1024")
    		set pfree (math -s2 "$pfree * 4096 / 1024 / 1024")
    		set pwired (math -s2 "$pwired * 4096 / 1024 / 1024")
    		set pinact (math -s2 "$pinact * 4096 / 1024 / 1024")
    		set panon (math -s2 "$panon * 4096 / 1024 / 1024")
    		set pcomp (math -s2 "$pcomp * 4096 / 1024 / 1024")
    		set ppurge (math -s2 "$ppurge * 4096 / 1024 / 1024")
    		set pfback (math -s2 "$pfback * 4096 / 1024 / 1024")

    		# OSX Activity monitor formulas
    		# thanks to http://apple.stackexchange.com/questions/81581/why-does-free-active-inactive-speculative-wired-not-equal-total-ram
    		set free (math -s2 "$pfree + $pinact" )
    		set cached (math "$pfback + $ppurge" )
    		set appmem  (math -s2 "$panon - $ppurge")
    		set used (math -s2 "$appmem + $pwired + $pcomp")

    		# Display the hud
    		printf '                 total     used     free   appmem    wired   compressed\n'
    		printf 'Mem:          %6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n' $total_mem $used $free $panon $pwired $pcomp
    		printf '+/- Cache:             %6.2f %6.2f\n' $cached $pinact
    		sysctl -n -o vm.swapusage | awk '{   if( $3+0 != 0 )  printf( "Swap(%2.0f%s):    %6.0fMb %6.0fMb %6.0fMb\n", ($6+0)*100/($3+0), "%", ($3+0), ($6+0), $9+0); }'
    		sysctl -n -o vm.loadavg | awk '{printf( "Load Avg:        %3.2f %3.2f %3.2f\n", $2, $3, $4);}'
    	else
    		command free $argv
    	end
       '';
    };
  };

  # Fish abbreviations
  programs.fish.shellAbbrs = { };

  # Fish alias : register alias command in fish
  programs.fish.shellAliases = {
    ls = "lsd";
    intel = "arch -x86_64";
    fixaudio = "sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod";
    # Nix related
    drb = "darwin-rebuild build --flake ~/.config/nixpkgs/";
    drs = "darwin-rebuild switch --flake ~/.config/nixpkgs/";
    # Flutter related
    dbr = "dart run build_runner build --delete-conflicting-outputs";
    ft = "flutter test";
    fc = "flutter clean";
    fu = "flutter upgrade";
    fpg = "flutter pub get";
    nerdfetch ="curl -fsSL https://raw.githubusercontent.com/ThatOneCalculator/NerdFetch/master/nerdfetch | sh";
  };
}
