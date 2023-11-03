{
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [ ];
    files = [ ];

    users.nonfinite = {
      directories = [
        "Code"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        "VirtualBox VMs"
      ];
    };
  };
}
