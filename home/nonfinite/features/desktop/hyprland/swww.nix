{ pkgs, ... }:
let
  set-wp = pkgs.writeTextFile {
    name = "set-wp";
    executable = true;
    destination = "/bin/set-wp";
    text = ''#!/usr/bin/env bash
    swww query
    if [ $? -eq 1 ]; then
      echo Initializing SWWW
      swww init

      echo Setting wallpaper to $1
      swww img $1
    else
      echo Setting wallpaper to $1

      transitions=("simple" "wipe" "any")
      tt=''${transitions[ $RANDOM % ''${#transitions[@]} ]}

      swww img $1 --transition-type $tt --transition-duration 2
    fi
    '';
  };
  set-wp-random = pkgs.writeTextFile {
    name = "set-wp-random";
    executable = true;
    destination = "/bin/set-wp-random";
    text = ''#!/usr/bin/env bash
    files=(
      "${../../../../../images/firewatch.jpg}"
      "${../../../../../images/lakeside_sunset.png}"
      "${../../../../../images/clockbirds/31d27ec380ebfc61a346d421441d31f4.png}"
      "${../../../../../images/clockbirds/aef2cbd2fa4f7c2f4f5931dfa6a60ad0.png}"
    )

    while : ; do
      file=''${files[ $RANDOM % ''${#files[@]} ]}
      [[ $(swww query) =~ $file ]] || break
    done


    ${set-wp}/bin/set-wp $file
    '';
  };
in
{
  home.packages = with pkgs; [
    set-wp
    set-wp-random
    swww
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "set-wp-random"
    ];

    bind = [
      "SUPER, P, exec, set-wp-random"
    ];
  };
}
