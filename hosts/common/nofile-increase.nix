{ ... }:
let
  limits = ''
    * soft     nproc          65535
    * hard     nproc          65535
    * soft     nofile         65535
    * hard     nofile         65535
  '';
in
{
  # https://unix.stackexchange.com/questions/8945/how-can-i-increase-open-files-limit-for-all-processes
  boot.kernel.sysctl = {
    "fs.file-max" = 65536;
  };

  # https://unix.stackexchange.com/a/10694
  environment.etc."security/limits.conf".text = limits;
  environment.etc."limits.conf".text = limits;
}
