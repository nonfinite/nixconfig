{ pkgs, ... }:
{
  home.packages = [ pkgs.scrcpy ];
  # Note: to get scrcpy working with Xiaomi phone: https://android.stackexchange.com/a/205536
  # `adb shell`
  # `su`
  # Enable root for shell via magisk by toggling [SharedUID] Shell
  # `su` again
  # `setprop persist.security.adbinstall 1`
  # `setprop persist.security.adbinput 1`
  # Edit /data/data/com.miui.securitycenter/shared_prefs/remote_provider_preferences.xml
  # to add `<boolean name="security_adb_install_enable" value="true" />`
  # via sed: `sed -i 's,"perm_adb_install_notify" value="true","perm_adb_install_notify" value="false",' /data/data/com.miui.securitycenter/shared_prefs/remote_provider_preferences.xml`
}
