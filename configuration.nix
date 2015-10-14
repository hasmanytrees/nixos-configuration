{ config, pkgs, ... }:

{
	imports = [
		./hardware-configuration.nix
	];


	# boot
	boot.loader.gummiboot.enable = true;
	boot.loader.efi.efiSysMountPoint = "/boot";


	# filesystem
	fileSystems."/".device = "/dev/disk/by-uuid/<root-uuid>";
	fileSystems."/boot".device = "/dev/disk/by-uuid/<boot-uuid>";
	fileSystems."/swap".device = "/dev/disk/by-uuid/<swap-uuid>";


	# networking
	networking.hostName = "nixos-mk1";
	networking.wireless.enable = true;


	# time zone
	time.timeZone = "America/Denver";


	# packages
	environment.systemPackages = with pkgs; [
		wget
		i3
		i3lock
		i3status
		dmenu
		xorg.xbacklight
		feh
		bar
		fish
		termite
		vim
		atom
		ubuntu_font_family
	];


	# x system
	services.xserver.enable = true;
	services.xserver.windowManager.i3.enable = true;
	services.xserver.synaptics.enable = true;
	services.xserver.synaptics.twoFingerScroll = true;

	fonts.fontconfig.ultimate.enable = true;


	# users
	users.extraUsers.forrest = {
		isNormalUser = true;
		home = "/home/forrest";
		description = "Forrest Robertson";
		extraGroups = [ "wheel" "networkmanager" ];
	};


	# nixos release
	system.stateVersion = "15.09";
}