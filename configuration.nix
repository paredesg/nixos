# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nixos-btw"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # autorise installation packages proprietaire
  nixpkgs.config.allowUnfree = true;

  #SSH 
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
    i18n.defaultLocale = "fr_FR.UTF-8";

    i18n.extraLocaleSettings = {
    # LC_ALL = "fr_FR.UTF-8"; # This overrides all other LC_* settings.
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

#    console = {
#      font = "Lat2-Terminus16";
#      keyMap = "fr";
#      useXkbConfig = true; # use xkb.options in tty.
#    };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
	services.xserver = {
		enable = true;
		windowManager.qtile.enable = true;
        xkb.layout = "fr";
	
	};

	#services.picom = {
	#	enable = true;
	#	backend = "glx";
	#	fade = true;
	#};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.loulou = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      bat
      curl
      dig
      hurl
      httpie
      mc
      terraform
    ];
  };

  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
		neovim
		alacritty
		btop
		gedit
		xwallpaper
		pcmanfm
		rofi
		git
		pfetch
  ];

	fonts.packages = with pkgs; [
		jetbrains-mono
	];

   system.stateVersion = "25.05"; # Did you read the comment?

}
