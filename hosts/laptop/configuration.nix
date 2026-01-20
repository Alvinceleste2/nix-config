{ pkgs, lib, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix

      ../../modules/hyprland.nix
      ../../modules/sddm.nix
    ];

  networking.hostName = "nixos";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Madrid"; 

  fonts.packages = with pkgs; [
    nerd-fonts.fantasque-sans-mono
  ];

  console.keyMap = "es";

  programs.zsh.enable = true;

  programs.firefox.enable = true;

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    vim 
    neovim
    wget
    htop
    neofetch
    home-manager
  ];

  users.users.alvinceleste = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" ];
  };

  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = "25.11";

}

