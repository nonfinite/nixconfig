args@{ inputs, lib, pkgs, ... }:
let
  diskConfig = {
    device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL21T0HCLR-00BL7_S64PNX0TA24210";
    tmpfsSize = "4G";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s

    (import ../common/disk-configs/impermanent (args // diskConfig))
    (import ../common/boot/grub.nix (args // diskConfig // { fontSize = 36; }))

    ../common/secrets
    ../common/global
    ../common/users/nonfinite
    (import ../common/users/autologin.nix "nonfinite")

    ../common/desktop/gnome
    ../common/games
    # ../common/virtualization/docker.nix
    ../common/virtualization/podman.nix
    ../common/virtualization/virt-manager.nix
    ../common/virtualization/waydroid.nix
    ../common/nofile-increase.nix
  ];

  networking = {
    hostName = "cardamom";
    hostId = "b626bba8";
    useDHCP = lib.mkDefault true;
    firewall.allowedTCPPorts = [
      # Vite dev port
      5173
    ];
  };

  security.sudo.wheelNeedsPassword = false;
  services.openssh = {
    enable = true;
    allowSFTP = true;
  };
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    git
    glxinfo # debug utilities for opengl, e.g. eglinfo
    sshfs
    android-tools
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
    ];
  };

  system.stateVersion = "23.05";

  # use most recent kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs = {
    adb.enable = true;
    light.enable = true;
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "i965";
    # MESA_GL_VERSION_OVERRIDE = "4.3";
  };
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  systemd.extraConfig = ''
    DefaultLimitNOFILE=65535
  '';
  systemd.user.extraConfig = ''
    DefaultLimitNOFILE=65535
  '';
}
