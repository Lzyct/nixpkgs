{
  description = "Lzyct’s Nix darwin system configs, and some other useful stuff.";

  inputs = {
    # Package sets
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # Environment/system management
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # Other sources
    # comma = { url = github:Shopify/comma; flake = false; };
    flake-compat = { url = github:edolstra/flake-compat; flake = false; };
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, darwin,nixpkgs, home-manager, flake-utils, ... }@inputs:
    let
      # Some building blocks ------------------------------------------------------------------- {{{

      inherit (darwin.lib) darwinSystem;
      inherit (inputs.nixpkgs-unstable.lib) attrValues makeOverridable optionalAttrs singleton;

      # Configuration for `nixpkgs`
      nixpkgsConfig = {
        config = { allowUnfree = true; };
        overlays = attrValues self.overlays ++ [
          # Sub in x86 version of packages that don't build on Apple Silicon yet
          (final: prev: (optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
            inherit (final.pkgs-x86)
 	      nix-index;
          }))
          (final: prev: {
            # TODO: remove when `nvim-lastplace` lands in `nixpkgs-unstable`
            vimPlugins = prev.vimPlugins.extend (_: _: {
              inherit (final.pkgs-master.vimPlugins) nvim-lastplace;
            });
          })
        ];
      };

      homeManagerStateVersion = "22.11";

      primaryUserInfo = {
        username = "Lzyct";
        fullName = "Lzyct";
        email = "hey.mudassir@gmail.com";
        nixConfigDirectory = "/Users/Lzyct/.config/nixpkgs";
      };

      # Modules shared by most `nix-darwin` personal configurations.
      nixDarwinCommonModules = attrValues self.darwinModules ++ [
        # `home-manager` module
        home-manager.darwinModules.home-manager
        (
          { config, ... }:
          let
            inherit (config.users) primaryUser;
          in
          {
            nixpkgs = nixpkgsConfig;
            # Hack to support legacy worklows that use `<nixpkgs>` etc.
            # nix.nixPath = { nixpkgs = "${primaryUser.nixConfigDirectory}/nixpkgs.nix"; };
            nix.nixPath = { nixpkgs = "${inputs.nixpkgs-unstable}"; };
            # `home-manager` config
            users.users.${primaryUser.username}.home = "/Users/${primaryUser.username}";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${primaryUser.username} = {
              imports = attrValues self.homeManagerModules;
              home.stateVersion = homeManagerStateVersion;
              home.user-info = config.users.primaryUser;
            };
            # Add a registry entry for this flake
            nix.registry.my.flake = self;
          }
        )
      ];
    in
    {

      # System outputs ------------------------------------------------------------------------- {{{
      # My `nix-darwin` configs
      darwinConfigurations = rec {
        # Mininal configurations to bootstrap systems
        bootstrap-x86 = makeOverridable darwinSystem {
          system = "x86_64-darwin";
          modules = [ ./darwin/bootstrap.nix { nixpkgs = nixpkgsConfig; } ];
        };
        bootstrap-arm = bootstrap-x86.override { system = "aarch64-darwin"; };

        # My Apple Silicon macOS laptop config
        Lzyct = darwinSystem {
          system = "aarch64-darwin";
          modules = nixDarwinCommonModules ++ [
            {
              users.primaryUser = primaryUserInfo;
              networking.computerName = "Lzyct 💻";
              networking.hostName = "Lzyct-MBP";
              networking.knownNetworkServices = [
                "Wi-Fi"
                "USB 10/100/1000 LAN"
              ];
            }
          ];
        };

        # Config with small modifications needed/desired for CI with GitHub workflow
        githubCI = darwinSystem {
          system = "x86_64-darwin";
          modules = nixDarwinCommonModules ++ [
            ({ lib, ... }: {
              users.primaryUser = primaryUserInfo // {
                username = "runner";
                nixConfigDirectory = "/Users/runner/work/nixpkgs/nixpkgs";
              };
              homebrew.enable = lib.mkForce false;
            })
          ];
        };
      };

      # Non-system outputs --------------------------------------------------------------------- {{{

      overlays = {
        # Overlays to add different versions `nixpkgs` into package set
        pkgs-master = _: prev: {
          pkgs-master = import inputs.nixpkgs-master {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-stable = _: prev: {
          pkgs-stable = import inputs.nixpkgs-stable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };
        pkgs-unstable = _: prev: {
          pkgs-unstable = import inputs.nixpkgs-unstable {
            inherit (prev.stdenv) system;
            inherit (nixpkgsConfig) config;
          };
        };

        #prefmanager = _: prev: {
        #  prefmanager = inputs.prefmanager.packages.${prev.stdenv.system}.default;
        #};

        # Overlay that adds various additional utility functions to `vimUtils`
        # vimUtils = import ./overlays/vimUtils.nix;

        # Overlay that adds some additional Neovim plugins
        # vimPlugins = final: prev:
        #  let
        #    inherit (self.overlays.vimUtils final prev) vimUtils;
        #  in
        #  {
        #    vimPlugins = prev.vimPlugins.extend (_: _:
        #      vimUtils.buildVimPluginsFromFlakeInputs inputs [
        #        # Add flake input name here
        #      ]
        #    );
        #  };

        # Overlay useful on Macs with Apple Silicon
        apple-silicon = _: prev: optionalAttrs (prev.stdenv.system == "aarch64-darwin") {
          # Add access to x86 packages system is running Apple Silicon
          pkgs-x86 = import inputs.nixpkgs-unstable {
            system = "x86_64-darwin";
            inherit (nixpkgsConfig) config;
          };
        };

        # Overlay to include node packages listed in `./pkgs/node-packages/package.json`
        # Run `nix run my#nodePackages.node2nix -- -14` to update packages.
        #nodePackages = _: prev: {
        #  nodePackages = prev.nodePackages // import ./pkgs/node-packages { pkgs = prev; };
        #};

        # Overlay that adds `lib.colors` to reference colors elsewhere in system configs
        #colors = import ./overlays/colors.nix;
      };

      darwinModules = {
        # My configurations
        lzyct-bootstrap = import ./darwin/bootstrap.nix;
        lzyct-defaults = import ./darwin/defaults.nix;
        lzyct-general = import ./darwin/general.nix;
        lzyct-homebrew = import ./darwin/homebrew.nix;

        # Modules I've created
        users-primaryUser =
          { lib, ... }:
          let
            inherit (lib) mkOption types;
          in
          {
            options = {
              users.primaryUser = {
                username = mkOption {
                  type = with types; nullOr string;
                  default = null;
                };
                fullName = mkOption {
                  type = with types; nullOr string;
                  default = null;
                };
                email = mkOption {
                  type = with types; nullOr string;
                  default = null;
                };
                nixConfigDirectory = mkOption {
                  type = with types; nullOr string;
                  default = null;
                };
              };
            };
          };
        programs-nix-index =
          # Additional configuration for `nix-index` to enable `command-not-found` functionality with Fish.
          { config, lib, pkgs, ... }:

          {
            config = lib.mkIf config.programs.nix-index.enable {
              programs.fish.interactiveShellInit = ''
                function __fish_command_not_found_handler --on-event="fish_command_not_found"
                  ${if config.programs.fish.useBabelfish then ''
                  command_not_found_handle $argv
                  '' else ''
                  ${pkgs.bashInteractive}/bin/bash -c \
                    "source ${config.programs.nix-index.package}/etc/profile.d/command-not-found.sh; command_not_found_handle $argv"
                  ''}
                end
              '';
            };
          };

        security-pam =
          # Upstream PR: https://github.com/LnL7/nix-darwin/pull/228
          { config, lib, pkgs, ... }:

            with lib;

            let
              cfg = config.security.pam;

              # Implementation Notes
              #
              # We don't use `environment.etc` because this would require that the user manually delete
              # `/etc/pam.d/sudo` which seems unwise given that applying the nix-darwin configuration requires
              # sudo. We also can't use `system.patchs` since it only runs once, and so won't patch in the
              # changes again after OS updates (which remove modifications to this file).
              #
              # As such, we resort to line addition/deletion in place using `sed`. We add a comment to the
              # added line that includes the name of the option, to make it easier to identify the line that
              # should be deleted when the option is disabled.
              mkSudoTouchIdAuthScript = isEnabled:
                let
                  file = "/etc/pam.d/sudo";
                  option = "security.pam.enableSudoTouchIdAuth";
                in
                ''
                  ${if isEnabled then ''
                    # Enable sudo Touch ID authentication, if not already enabled
                    if ! grep 'pam_tid.so' ${file} > /dev/null; then
                      sed -i "" '2i\
                    auth       sufficient     pam_tid.so # nix-darwin: ${option}
                      ' ${file}
                    fi
                  '' else ''
                    # Disable sudo Touch ID authentication, if added by nix-darwin
                    if grep '${option}' ${file} > /dev/null; then
                      sed -i "" '/${option}/d' ${file}
                    fi
                  ''}
                '';
            in

            {
              options = {
                security.pam.enableSudoTouchIdAuth = mkEnableOption ''
                  Enable sudo authentication with Touch ID
                  When enabled, this option adds the following line to /etc/pam.d/sudo:
                      auth       sufficient     pam_tid.so
                  (Note that macOS resets this file when doing a system update. As such, sudo
                  authentication with Touch ID won't work after a system update until the nix-darwin
                  configuration is reapplied.)
                '';
              };

              config = {
                system.activationScripts.extraActivation.text = ''
                  # PAM settings
                  echo >&2 "setting up pam..."
                  ${mkSudoTouchIdAuthScript cfg.enableSudoTouchIdAuth}
                '';
              };
            };
      };

      homeManagerModules = {
        # My configurations
        lzyct-config-files = import ./home/config-files.nix;
        lzyct-git = import ./home/git.nix;
        lzyct-fish = import ./home/fish.nix;
        lzyct-vim = import ./home/vim.nix;
        lzyct-go = import ./home/go.nix;
        lzyct-packages = import ./home/packages.nix;

        # Modules I've created
        # programs-neovim-extras = import ./modules/home/programs/neovim/extras.nix;
        home-user-info = { lib, ... }: {
          options.home.user-info =
            (self.darwinModules.users-primaryUser { inherit lib; }).options.users.primaryUser;
        };
      };
      #I }}}

      # Add re-export `nixpkgs` packages with overlays.
      # This is handy in combination with `nix registry add my /Users/Lzyct/.config/nixpkgs`
    } // flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import inputs.nixpkgs-unstable {
        inherit system;
        inherit (nixpkgsConfig) config;
        overlays = with self.overlays; [
          pkgs-master
          pkgs-stable
          apple-silicon
        ];
      };
    });
}
# vim: foldmethod=marker
