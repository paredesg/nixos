{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
  diskoo = builtins.fetchTarball https://github.com/nix-community/disko/archive/master.tar.gz;
in


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko-config.nix
      (import "${home-manager}/nixos")
      (import "${diskoo}/module.nix")
    ];


   # Configure Home Manager for your user
  users.users.eve = {
    isNormalUser = true;
    description = "Utilisateur TEST";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  users.users.eve.openssh.authorizedKeys.keyFiles = [
    /etc/nixos/authorized_keys
  ];

  home-manager.users.eve = { pkgs, ... }: {
    # Add packages you want installed for this user
    # home.packages = [ pkgs.atool pkgs.httpie ];
    programs.bash.enable = true;
  
    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "25.05";
  };

  # Use the systemd-boot EFI boot loader.
  # VM VirtualBox OK
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # VM VirtualBox OK

  #boot.loader.grub.enable = true;
  #boot.loader.grub.efiSupport = true;
  #boot.loader.grub.efiInstallAsRemovable = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure console keymap
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  ## Enable the X11 windowing system.
  #services.xserver = {
  #    xkb.layout = "fr";
  #    xkb.variant = "";
  #    enable = true;
  #    displayManager = {
  #        sddm.enable = true;
  #        sddm.theme = "maya";
  #        sddm.autoNumlock = true;
  #    };
  #};
#
#
  #programs.hyprland = {
  #    enable = true;
  #};
#
  #programs.hyprland.xwayland = {
  #    enable = true;
  #};
 
  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    htop
    pciutils
    hyprland
    ranger
    rofi-wayland
    waybar
    wofi
    terraform
    docker
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;






  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  system.stateVersion = "25.05"; # Did you read the comment?

}

