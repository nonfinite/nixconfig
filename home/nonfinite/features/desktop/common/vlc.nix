{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vlc
  ];

  home.file.".config/vlc/vlcrc".text = ''
    [main]
    video-title-show=0
    loop=1
    [qt]
    qt-privacy-ask=0
  '';
}
