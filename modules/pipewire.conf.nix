{ config, lib, pkgs, ... }:

{
  xdg.configFile."pipewire/pipewire.conf" = {
    source = pkgs.substituteAll {
      src = ../etc/pipewire.conf;
      rnnoise = pkgs.rnnoise-plugin.out;
    };
  };
}
