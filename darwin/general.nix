{ pkgs, ... }:

# Docs : https://daiderd.com/nix-darwin/manual/index.html

{
  # Networking
  networking.dns = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    dnscrypt-proxy2
    terminal-notifier
  ];

  programs.nix-index.enable = true;

  # Fonts TEMPORARY DISABLE THIS CONFIG not working on Ventura
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
     recursive
     (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" "Hack" ]; })
   ];

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = false;

  # Disable iCloud sync
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

  # Networks
  # dnscrypt-proxy
  launchd.user.agents.dnscrypt-proxy = {
    serviceConfig.RunAtLoad = true;
    serviceConfig.KeepAlive = true;
    serviceConfig.ProgramArguments = [
      "${pkgs.dnscrypt-proxy2}/bin/dnscrypt-proxy"
      "-config"
      (toString (pkgs.writeText "dnscrypt-proxy.toml" ''
        server_names = ['google', 'cloudflare', 'cloud9']
        listen_addresses = ["127.0.0.1:5053"]
      ''))
    ];
  };
}
