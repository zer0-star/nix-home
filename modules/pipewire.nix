{
  config,
  lib,
  pkgs,
  ...
}:
{
  xdg.configFile = {
    # "pipewire/pipewire.conf" = {
    #   source = pkgs.substituteAll {
    #     src = ../etc/pipewire.conf;
    #     rnnoise = pkgs.rnnoise-plugin.out;
    #   };
    # };
    # "wireplumber/wireplumber.conf.d/50-alsa.conf".text = ''
    #   alsa.monitor.rules = [
    #     {
    #       matches = [
    #         {
    #           node.name = "~alsa_input.*"
    #         }
    #         {
    #           -- Matches all sinks.
    #           node.name = "~alsa_output.*"
    #         }
    #       ]
    #       actions = {
    #         update-props = {
    #           session.suspend-timeout-seconds = 0
    #         }
    #       }
    #     }
    #   ]
    # '';
    "wireplumber/wireplumber.conf.d/51-bluez.conf".text = ''
      monitor.bluez.rules = [
        {
          matches = [
            {
              ## Matches all sources.
              node.name = "~bluez_input.*"
            }
            {
              ## Matches all sinks.
              node.name = "~bluez_output.*"
            }
          ]
          actions = {
            update-props = {
              bluez5.roles = [ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]
              session.suspend-timeout-seconds = 0
            }
          }
        }
      ]
    '';
  };
}
