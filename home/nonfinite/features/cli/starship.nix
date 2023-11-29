{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = { };
  };

  programs.bash.bashrcExtra = ''
    function set_title_to_current_dir(){
      echo -ne "\033]0; $(dirs) \007"
    }
    starship_precmd_user_func="set_title_to_current_dir"
  '';
}
