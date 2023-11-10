{
  programs.bash.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      mkdir /tmp/log &> /dev/null
      exec Hyprland &> /tmp/log/hyprland
    fi
  '';
}
