{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  # Standard .config/directory
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    rofi = "rofi";
    alacritty = "alacritty";
    picom = "picom";
    ranger = "ranger";
    bat = "bat";
    mc = "mc";
  };
in

{
  home.username = "eve";
  home.homeDirectory = "/home/eve";

  programs.git.enable = true;
  programs.firefox.enable = true;
  programs.direnv.enable = true;
  #services.tailscale.enable = true;
  #virtualisation.docker.enable = true;
  #programs.ssh.startAgent = true;

  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      l = "eza -l --icons=auto -a --group-directories-first";
      ll = "ls -l";
      conf = "sudo vim /etc/nixos/configuration.nix";
      nixr = "sudo nixos-rebuild switch";
      qtileconf= "sudo vim /home/eve/.config/qtile/config.py";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw";
    };
    initExtra = ''
      	  export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      	'';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    rofi
    xwallpaper
    eza # ls 
    mc # midnight commander
    bat # better cat
  ];

}

