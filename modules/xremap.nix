{
  config,
  pkgs,
  lib,
  ...
}: let
  laptop-kb = "AT Translated Set 2 keyboard";
in {
  services.xremap = {
    withWlroots = true;
    # debug = true;
    deviceNames = [laptop-kb];
    config = {
      modmap = [
        {
          name = "default";
          remap = {
            CapsLock = "C_L";
          };
        }
      ];
      keymap = [
        {
          name = "default";
          application = {
            not = ["Alacritty" "kitty"];
          };
          remap = {
            "C_L-a" = "home";
            "C_L-e" = "end";
            "C_L-k" = "C_R-Shift-delete";
            "C_L-m" = "enter";
            "C_L-h" = "backspace";
          };
        }
      ];
    };
  };

  systemd.user.services.xremap2 = {
    Unit = {
      Description = "xremap service (for US)";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target" "xremap.service"];
    };
    Service = {
      Type = "simple";
      ExecStart =
        builtins.replaceStrings
        ["device"]
        ["watch=device --ignore"]
        config.systemd.user.services.xremap.Service.ExecStart;
      Restart = "always";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
