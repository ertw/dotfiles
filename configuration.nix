# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
imports =
  [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];


  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

programs.zsh.enable = true;

system.autoUpgrade.enable = true;

services.postgresql.enable = true;

environment.systemPackages = with pkgs; [
	i3status dmenu firefox atom xorg.xbacklight
  	connman openvpn arp-scan pcmanfm p7zip nmap inkscape
  	pinta icedtea8_web htop openssh sshfsFuse freerdp
  	powertop git busybox grc flpsed zlib libxml2
  	python phantomjs2 iotop trash-cli mtr zeal zsh
  	stack ghc cabal-install openssl gcc elmPackages.elm
  	redshift gparted ntfs3g icedtea8_web shutter neovim
  	minicom termite powerline-fonts gnumake clang zathura
	calibre rustc cargo transmission python35Packages.slackclient 
	pltScheme ruby cmake mosh autorandr arandr
#	 chromiumDev 
];

fonts = {
     enableFontDir = true;
     enableGhostscriptFonts = true;
     fonts = with pkgs; [
       corefonts  # Micrsoft free fonts
       fantasque-sans-mono  # monospaced
       ubuntu_font_family  # Ubuntu fonts
       unifont # some international languages
     ];
   };

nixpkgs.config = {
  allowUnfree = true;
  firefox = {
  };
#  chromium = {
#    enablePepperPDF = true;
#  };
};

  # Use the gummiboot efi boot loader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking = {
	hostName = "nixtop";
	wireless.enable = true;
	connman.enable = true;
};

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
time.timeZone = "US/Pacific";



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.

virtualisation.virtualbox.host.enable = true;

services.xserver = {
	enable = true;
	windowManager.i3.enable = true;
	layout = "us";

  config = ''
    Section "InputClass"
      Identifier "TPPS/2 IBM TrackPoint"
      MatchProduct "TPPS/2 IBM TrackPoint"
      MatchDevicePath "/dev/input/event*"
      Option "EmulateWheel" "true"
      Option "EmulateWheelButton" "2"
      Option "ButtonMapping" "1 2 3 5 4"
    EndSection

    Section "InputClass"
      Identifier "keyboard catchall"
      MatchIsKeyboard "on"
      Option "XKbOptions" "shift:both_capslock,ctrl:nocaps"
    EndSection
    '';

};
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.kdm.enable = true;
  # services.xserver.desktopManager.kde4.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
users.defaultUserShell = "/run/current-system/sw/bin/zsh";
users.extraUsers.ertw = {
  isNormalUser = true;
  description = "Erik Williamson";
  extraGroups = [ "wheel" "vboxusers" ];
};

  # The NixOS release to be compatible with for stateful data such as databases.
system.stateVersion = "16.03";
}
