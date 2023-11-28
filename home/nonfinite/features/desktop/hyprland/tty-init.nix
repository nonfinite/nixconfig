{
  programs.bash.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ] && [ ! -e /tmp/log/hyprland ]; then
      mkdir /tmp/log &> /dev/null
      exec Hyprland &> /tmp/log/hyprland
    fi
  '';
}
