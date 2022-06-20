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
  '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;


  # Shells -----------------------------------------------------------------------------------------

  programs.zsh.enable = true;

  # Add shells installed by nix to /etc/shells file
  environment.shells = with pkgs; [
    bashInteractive
    zsh
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
