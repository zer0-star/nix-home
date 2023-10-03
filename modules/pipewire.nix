{ config, lib, pkgs, ... }:

{
  xdg.configFile = {
    "pipewire/pipewire.conf" = {
      source = pkgs.substituteAll {
        src = ../etc/pipewire.conf;
        rnnoise = pkgs.rnnoise-plugin.out;
      };
    };
    "wireplumber/bluetooth.lua.d/50-bluez-config.lua".text = ''
      bluez_monitor.properties = {
  			["bluez5.enable-sbc-xq"] = true,
  			["bluez5.enable-msbc"] = true,
  			["bluez5.enable-hw-volume"] = true,
  			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",

        ["bluez5.codecs"] = "[ aac ldac aptx aptx_hd sbc sbc_xq ]",
        ["bluez5.a2dp.ldac.quality"] = "hq",
      }
    '';
  };
}
