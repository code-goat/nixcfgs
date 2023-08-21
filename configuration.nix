# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # //CUSTOM FIXES
    # Network Manager Fix	
  	 # systemd.services.NetworkManager-wait-online.enable = false;

  # //NIXOS SETTINGS
    # Enable nix command and flakes
      nix = {
        package = pkgs.nixFlakes;
        extraOptions = ''
        experimental-features = nix-command flakes
        '';
      };

    # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

  # //BOOT
    # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
    # Setup keyfile
      boot.initrd.secrets = {
      "/crypto_keyfile.bin" = null;
      };

  # //NETWORKING
  	# Enable networking
      networking.networkmanager.enable = true;
    
    # Firewall
  	  networking.firewall.enable = false;
      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];

	  # WoL (Wake-on-LAN) Support
	 	 powerManagement.enable = true;
     	 networking.interfaces.tailscale0.wakeOnLan.enable = true;
     	 networking.interfaces.enp2s0.wakeOnLan.enable = true;
     	 networking.hostName = "nixos"; # Define Hostname

    # Enables wireless support via wpa_supplicant.
    # networking.wireless.enable = true;  

    # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
        
    # Set your time zone.
      time.timeZone = "America/Los_Angeles";
    
    # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
       };
      
  # //SERVICES
     
    # OpenSSH daemon.
      services.openssh.enable = true;


    # FLATPAK support
      services.flatpak.enable = true;
 
 
  # //WINDOW MANAGEMENT
      # Enable the X11 windowing system.
        services.xserver.enable = true;
        services.xserver.videoDrivers = [ "amdgpu" ];
        services.tailscale.enable = true;
      # Configure keymap in X11
        services.xserver = {
         layout = "us";
         xkbVariant = "";
         };

  # //DESKTOP ENVIRONMENT
      # Enable the KDE Plasma Desktop Environment.
        services.xserver.displayManager.sddm.enable = true;
        services.xserver.desktopManager.plasma5.enable = true;

      # Enable touchpad support (enabled default in most desktopManager).
        services.xserver.libinput.enable = true;   

  # //DRIVES & FILESYSTEMS
  	  # Enable swap on luks
        boot.initrd.luks.devices."luks-ac0cfc22-6519-40f1-b251-9364814b8628".device = "/dev/disk/by-uuid/ac0cfc22-6519-40f1-b251-9364814b8628";
        boot.initrd.luks.devices."luks-ac0cfc22-6519-40f1-b251-9364814b8628".keyFile = "/crypto_keyfile.bin";
      # zram
        zramSwap.enable = true;

  # //FONTS
       fonts.fontDir.enable = true;
       fonts = {
          fonts = with pkgs; [
             noto-fonts
             noto-fonts-cjk
             noto-fonts-emoji
             font-awesome
             source-han-sans
             source-han-sans-japanese
             source-han-serif-japanese
          (nerdfonts.override { fonts = [ "Meslo" ]; })
          ];
        fontconfig = {
          enable = true;
           defaultFonts = {
  	          monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
  	          serif = [ "Noto Serif" "Source Han Serif" ];
  	          sansSerif = [ "Noto Sans" "Source Han Sans" ];
           };
          };
        };
  
  # //VIRTUALIZATION
    # Podman Backend
      virtualisation.oci-containers.backend = "podman";
    
    # Docker
      #virtualisation.docker.rootless.enable = true;
      #virtualisation.libvirtd.enable = true;
      #virtualisation.docker.enable = true;
  
  # //PRINTING
    # Enable CUPS to print documents.
      services.printing.enable = true;
  
  # //AUDIO
    # Enable sound with pipewire.
      sound.enable = true;
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
       #media-session.enable = true;
      }; 
  
  # //USER MANAGEMENT & PKGs
    # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.common = {
         isNormalUser = true;
         description = "common";
         extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
         firefox
         kate
         librewolf
         libsForQt5.yakuake
        ];
      };

  # //USER PROGRAMS & SERVICES
    # User added programs services
      programs.git.enable = true;
      programs.partition-manager.enable = true;
      programs.kdeconnect.enable = true;
      programs.fish.enable = true;

  # //SYSTEM PACKAGES
    # To search, run: $ nix search wget
    environment.systemPackages = with pkgs; [
      timeshift
      wget
      element-desktop
      git
      bitwarden
      google-fonts
      corefonts
      neovim
      micro
      unzip
      filelight
      virt-manager
      vscodium
       (vscode-with-extensions.override {
         vscode = vscodium;
         vscodeExtensions = with vscode-extensions; [
             antyos.openscad
              jnoortheen.nix-ide
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         ];
        })
      gnupg
      direnv
      gparted
      btrfs-progs
      ffmpeg
      vlc
      jellyfin-ffmpeg
      tldr
      anytype
     ];

  
  # //MISC
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    programs.mtr.enable = true;
    programs.gnupg.agent = {
       enable = true;
       enableSSHSupport = true;
    };

  # //NIXOS VERSION
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
    
}

