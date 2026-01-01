{ config, lib, pkgs, ... }:
  
{

  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings = {
    download-buffer-size = 4194304000 ; # 4GB
  };


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # disable wireless for conflit with networkmanager
  networking.wireless.enable = false;

  # Enable bluetooth.
  #hardware.bluetooth.enable = true; # enables support for Bluetooth
  #hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  #services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # autorise installation packages proprietaire
  nixpkgs.config.allowUnfree = true;

  # Enable the LY display manager.
  services.displayManager.ly.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.qtile.enable = true;
    xkb.layout = "fr";
    displayManager.sessionCommands = ''
      xwallpaper --zoom ~/nixos-dotfiles/walls/wall1.png
    '';
    extraConfig = ''
      	Section "Monitor"
      	  Identifier "Virtual-1"
      	  Option "PreferredMode" "1920x1080"
      	EndSection
    '';
  };

  # Enable the Picom compositor.
  services.picom.enable = true;

  #SSH
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
  LC_CTYPE = "fr_FR.UTF8";
  LC_ADDRESS = "fr_FR.UTF-8";
  LC_MEASUREMENT = "fr_FR.UTF-8";
  LC_MESSAGES = "fr_FR.UTF-8";
  LC_MONETARY = "fr_FR.UTF-8";
  LC_NAME = "fr_FR.UTF-8";
  LC_NUMERIC = "fr_FR.UTF-8";
  LC_PAPER = "fr_FR.UTF-8";
  LC_TELEPHONE = "fr_FR.UTF-8";
  LC_TIME = "fr_FR.UTF-8";
  LC_COLLATE = "fr_FR.UTF-8";
  };

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.eve = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}

