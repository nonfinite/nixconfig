{ pkgs, ... }:
let
  set-wp = pkgs.writeTextFile {
    name = "set-wp";
    executable = true;
    destination = "/bin/set-wp";
    text = ''#!/usr/bin/env bash
    swww query
    if [ $? -eq 1 ]; then
      swww init
    fi

    swww img $1
    '';
  };
in
{
  home.packages = with pkgs; [
    set-wp
    swww
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "set-wp ${../../../../../images/firewatch.jpg}"
  ];
}
