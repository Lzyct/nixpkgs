{ config, pkgs, ... }:

{
  # Git
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.git.enable
  # Aliases config in ./configs/git-aliases.nix
  programs.git.enable = true;

  programs.git.ignores = [
    ".DS_Store"
  ];

  programs.git.settings.user.email = config.home.user-info.email;
  programs.git.settings.user.name = config.home.user-info.fullName;
}
