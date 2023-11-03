{ user, ... }:
{
  services.getty.autologinUser = user;

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = user;
}
