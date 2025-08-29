{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
#    enableFishIntegration = config.programs.fish.enable;
#    enableBashIntegration = config.programs.bash.enable;
#    enableTransience = config.programs.fish.enable;

    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = true;
      command_timeout = 5000;
      character = {
         success_symbol = ''[ ↳](bold yellow)'';
         error_symbol = ''[ ↳](bold red)'';
       };

      package.disabled = false;
      palette = ''catppuccin_mocha'';

      gcloud = {
            format = '''';
      };

      palettes = {
        catppuccin_mocha = {
          rosewater = ''#f5e0dc'';
          flamingo = ''#f2cdcd'';
          pink = ''#f5c2e7'';
          mauve = ''#cba6f7'';
          red = ''#f38ba8'';
          maroon = ''#eba0ac'';
          peach = ''#fab387'';
          yellow = ''#f9e2af'';
          green = ''#a6e3a1'';
          teal = ''#94e2d5'';
          sky = ''#89dceb'';
          sapphire = ''#74c7ec'';
          blue = ''#89b4fa'';
          lavender = ''#b4befe'';
          text = ''#cdd6f4'';
          subtext1 = ''#bac2de'';
          subtext0 = ''#a6adc8'';
          overlay2 = ''#9399b2'';
          overlay1 = ''#7f849c'';
          overlay0 = ''#6c7086'';
          surface2 = ''#585b70'';
          surface1 = ''#45475a'';
          surface0 = ''#313244'';
          base = ''#1e1e2e'';
          mantle = ''#181825'';
          crust = ''#11111b'';
        };
      };

      # directory symbol nerd font


      directory = {
        format = ''[](fg:mantle)[   $path ]($style)[](fg:mantle) '';
#        truncation_length = 255;
#         truncation_symbol = ''󰍻'';
#        truncate_to_repo = false;
#        use_logical_path = false;
        style = ''bg:mantle fg:blue bold'';
#        substitutions = {
#         Workspace = ''󱃪 '';
#         Documents = ''󰈙 '';
#         Downloads = '' '';
#         Music = '' '';
#         Pictures = ''  '';
#         Desktop = ''  '';
#         Videos = ''  '';
#         Home = ''  '';
#        };
      };

      git_branch = {
        format = ''[](fg:mantle)[ $symbol $branch ]($style)[](fg:mantle) '';
        style = ''bg:mantle fg:sky'';
        symbol = '''';
      };

      git_status = {
        disabled = false;
        style = ''bg:mantle fg:red'';
        format = ''[](fg:mantle)([$all_status$ahead_behind]($style))[](fg:mantle) '';
        up_to_date = ''[ ✓ ](bg:mantle fg:teal)'';
        untracked = ''[?($count)](bg:mantle fg:peach)'';
        stashed = ''[\$](bg:mantle fg:mauve)'';
        modified = ''[!($count)](bg:mantle fg:flamingo)'';
        renamed = ''[»($count)](bg:mantle fg:mauve)'';
        deleted = ''[✘($count)](style)'';
        staged = ''[++($count)](bg:mantle fg:peach)'';
        ahead = ''[⇡($count)](bg:mantle fg:teal)'';
        diverged = ''⇕[[](bg:mantle fg:mauve)[⇡($ahead_count)](bg:mantle fg:teal)[⇣($behind_count)](bg:mantle fg:pink)[]](bg:mantle fg:mauve)'';
        behind = ''[⇣($count)](bg:mantle fg:pink)'';
      };

      # Language and tool configurations
           aws = {
             format = ''[](fg:mantle)[$symbol($profile)(\($region\))(\[$duration\])]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = '' '';
           };

           c = {
             format = ''[](fg:mantle)[$symbol($version(-$name))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           cmake = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = ''󰘳 '';
           };

           cmd_duration = {
             format = ''[](fg:mantle)[󰄉 $duration]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
           };

           cobol = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''⚙️ '';
           };

           conda = {
             format = ''[](fg:mantle)[$symbol$environment]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = ''🅒 '';
           };

           crystal = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           daml = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰏖 '';
           };

           dart = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           deno = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = '' '';
           };

           docker_context = {
             format = ''[](fg:mantle)[$symbol$context]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰡨 '';
           };

           dotnet = {
             format = ''[](fg:mantle)[$symbol($version)(🎯 $tfm)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = ''󰪮 '';
           };

           elixir = {
             format = ''[](fg:mantle)[$symbol($version \(OTP $otp_version\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = '' '';
           };

           elm = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:teal'';
             symbol = '' '';
           };

           erlang = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           fennel = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = '' '';
           };

           fossil_branch = {
             format = ''[](fg:mantle)[$symbol$branch]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰣖 '';
           };

           golang = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:teal'';
             symbol = '' '';
           };

           gradle = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = '' '';
           };

           guix_shell = {
             format = ''[](fg:mantle)[$symbol]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           haskell = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = '' '';
           };

           haxe = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:flamingo'';
             symbol = '' '';
           };

           helm = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰙏 '';
           };

           hg_branch = {
             format = ''[](fg:mantle)[$symbol$branch]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = '' '';
           };

           java = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           julia = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = '' '';
           };

           kotlin = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           kubernetes = {
             format = ''[](fg:mantle)[$symbol$context( \($namespace\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰠳 '';
           };

           lua = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           memory_usage = {
             format = ''[](fg:mantle)[$symbol[$ram( | $swap)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = ''󰍛 '';
           };

           meson = {
             format = ''[](fg:mantle)[$symbol$project]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = ''󰔷 '';
           };

           nim = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = ''󰆥 '';
           };

           nix_shell = {
             format = ''[](fg:mantle)[$symbol$state( \($name\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           nodejs = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:green'';
             symbol = ''󰎙 '';
           };

           ocaml = {
             format = ''[](fg:mantle)[$symbol($version)(\($switch_indicator$switch_name\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = '' '';
           };

           opa = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰚩 '';
           };

           openstack = {
             format = ''[](fg:mantle)[$symbol$cloud(\($project\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰙭 '';
           };

           os = {
             format = ''[](fg:mantle)\[[$symbol]($style)\][](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbols = {
                    Arch = ''󰏜 '';
                    Ubuntu = ''󰏚 '';
                    Macos = '' '';
                    Windows = '' '';
                };
           };

           package = {
              format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
              style = ''bg:mantle fg:yellow'';
              symbol = ''󰏗 '';
           };

           perl = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           php = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           pijul_channel = {
             format = ''[](fg:mantle)[$symbol$channel]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰚩 '';
           };

           pulumi = {
             format = ''[](fg:mantle)[$symbol$stack]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:mauve'';
             symbol = ''󰆧 '';
           };

           purescript = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:maroon'';
             symbol = '' '';
           };

           python = {
             format = ''[](fg:mantle)[$symbol$pyenv_prefix($version)(\($virtualenv\))]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = '' '';
           };

           raku = {
             format = ''[](fg:mantle)[$symbol($version-$vm_version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = '' '';
           };

           red = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           ruby = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           rust = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:flamingo'';
             symbol = '' '';
           };

           scala = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:red'';
             symbol = '' '';
           };

           spack = {
             format = ''[](fg:mantle)[$symbol$environment]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:blue'';
             symbol = ''󰙲 '';
           };

           sudo = {
             format = ''[](fg:mantle)[as $symbol]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:yellow'';
             symbol = ''󰚀 '';
           };

           swift = {
             format = ''[](fg:mantle)[$symbol($version)]($style)[](fg:mantle)'';
             style = ''bg:mantle fg:flamingo'';
             symbol = '' '';
           };

           time = {
             format = "[](fg:mantle)[ $time 󰴈 ]($style)[](fg:mantle)";
             style = "bg:mantle fg:rose";
             time_format = "%I:%M%P";
             use_12hr = true;
           };
    } ;
  };
}
