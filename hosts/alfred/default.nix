# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, system_settings, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      default = "saved";
      extraEntries = "GRUB_SAVEDEFAULT=true";
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
    };
  };

  networking.hostName = system_settings.hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.package = with pkgs; [ bluez ];

  # Set your time zone.
  time.timeZone = system_settings.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = system_settings.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = system_settings.locale;
    LC_IDENTIFICATION = system_settings.locale;
    LC_MEASUREMENT = system_settings.locale;
    LC_MONETARY = system_settings.locale;
    LC_NAME = system_settings.locale;
    LC_NUMERIC = system_settings.locale;
    LC_PAPER = system_settings.locale;
    LC_TELEPHONE = system_settings.locale;
    LC_TIME = system_settings.locale;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    age
    chezmoi
    pulseaudio
    home-manager
    wpa_supplicant
  ];

  fonts.fontconfig.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
