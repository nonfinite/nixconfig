{ config, lib, ... }:
with lib;
let
  cfg = config.exec-once;
in
{
  options.exec-once = {
    commands = mkOption {
      type = with types; listOf str;
      default = [ ];
    };
  };

  config = {
    home.file.".config/autostart/exec-once.sh" = {
      executable = true;
      text =
        let lines = builtins.concatStringsSep "\n" (builtins.map (command: "${command} &") cfg.commands);
        in ''
          #!/usr/bin/env bash
          ${lines}
        '';
    };
    home.file.".config/autostart/exec-once.desktop".text = ''
      [Desktop Entry]
      Name=exec-once
      Type=Application
      Exec=/home/nonfinite/.config/autostart/exec-once.sh
      Terminal=false
    '';
  };
}
