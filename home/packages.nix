{ config, lib, pkgs, ... }:

{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.bat.enable
  #  programs.bat.enable = true;
  #  programs.bat.config = {
  #    style = "plain";
  #  };

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  # programs.direnv.enable = true;
  # programs.direnv.nix-direnv.enable = true;

  # Htop
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.htop.enable
  programs.htop.enable = true;
  programs.htop.settings.show_program_path = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.zoxide.enable
  # programs.zoxide.enable = true;


  home.packages = with pkgs; [
    # Some basics
    #dart
    git
    curl
    tree
    cascadia-code
    exa # fancy version of `ls`
    fd # fancy version of `find`
    htop # fancy version of `top`
    neofetch
    wget
    yarn
    nodejs
    google-cloud-sdk
    jq

    tokei # get information about current project

    # Useful nix related tools
    cachix # adding/managing alternative binary caches hosted by Cachix
    comma # run software from without installing it
    niv # easy dependency management for nix projects
    nix-tree # interactively browse dependency graphs of Nix derivations
    nix-update # swiss-knife for updating nix packages
    nixpkgs-review # review pull-requests on nixpkgs
    statix # lints and suggestions for the Nix programming language
    starship # cross-shell prompt

  ] ++ lib.optionals stdenv.isDarwin [
    # cocoapods preferably installed via homebrew to get latest version
    m-cli # useful macOS CLI commands
    xcode-install
  ];
}
