{
  programs.bash.profileExtra = ''
    if [ "$(tty)" = "/dev/tty1" ] && [ ! -e /tmp/log/sway ]; then
      mkdir /tmp/log &> /dev/null
      exec sway &> /tmp/log/sway
    fi
  '';
}
