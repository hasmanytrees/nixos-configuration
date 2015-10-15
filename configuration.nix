# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "nos-mk1"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # Set your time zone.
  time.timeZone = "America/Denver";


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    i3
    i3lock
    i3status
    dmenu
    xorg.xbacklight
    feh
    bar
    termite
    fish
    vim
    atom
    ubuntu_font_family
  ];


  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  fonts.fontconfig.ultimate.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.forrest = {
    isNormalUser = true;
    home = "/home/forrest";
    description = "Forrest Robertson";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish + "/bin/fish";
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";
}
