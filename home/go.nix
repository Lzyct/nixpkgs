{ config, pkgs, lib,... }:

{
   # Setup go
   programs.go.enable = true;
   programs.go.package = with pkgs;go.overrideAttrs (oldAttrs: rec { 
    # write new attr 
    version = "1.18.3";
    src = fetchurl {
      url = "https://dl.google.com/go/go${version}.src.tar.gz";
      sha256 = "sha256-ABI4bdy7XzNQ5AfGeZI4EdvSg/zcQhckkxYUqELsvC0=";
    };
  });
}