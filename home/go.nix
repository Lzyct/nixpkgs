{ config, pkgs, lib,... }:

{
   # Setup go
   programs.go.enable = true;
   programs.go.package = with pkgs;go.overrideAttrs (oldAttrs: rec { 
    # write new attr 
    version = "1.18.4";
    src = fetchurl {
      url = "https://dl.google.com/go/go${version}.src.tar.gz";
      sha256 = "sha256-RSWqaw487LV4RfQGCnB1qvyat1K7e2tM+KIS1DB44eQ=";
    };
  });
}