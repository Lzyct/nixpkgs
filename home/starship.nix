{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      add_newline = true;

      character = {
         success_symbol = "[・➤](bold green)";
         error_symbol = "[・➤](bold red)";
       };

      package.disabled = false;

      dart = {
        format = "via [🔰 $version](bold red) ";
      };

      gcloud = {
            format = "";
      };

    };
  };
}