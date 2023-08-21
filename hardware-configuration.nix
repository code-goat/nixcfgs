# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    <nixos-hardware/common/cpu/amd>
    <nixos-hardware/common/gpu/amd>
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/4a5a642c-4a1a-410a-8a3d-9bced3e98a6f";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-f72a641d-26d7-4c86-9d65-22bdea001256".device = "/dev/disk/by-uuid/f72a641d-26d7-4c86-9d65-22bdea001256";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4876-F00E";
      fsType = "vfat";
    };
     
  swapDevices =
    [ { device = "/dev/disk/by-uuid/44337458-45c2-493d-b1ae-d0a7d481c057"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.driSupport = true;
}