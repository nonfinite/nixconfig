user:
{
  services.getty.autologinUser = user;

  services.displayManager.autoLogin = {
    enable = true;
    user = user;
  };
}
