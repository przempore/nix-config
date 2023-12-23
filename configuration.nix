# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "porebski" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-49bd7c90-424e-49ea-ad4a-df346efbf6d3".device = "/dev/disk/by-uuid/49bd7c90-424e-49ea-ad4a-df346efbf6d3";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "dooku"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  services.xserver = {
    enable = true;   
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    # displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.bspwm.enable = true;
    displayManager.defaultSession = "none+bspwm";
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.slick.enable = true;
  };

  services.xserver.extraLayouts.real-prog-dvorak = {
    description = "Real proogrammer dvorak";
    languages = [ "pl" ];
    symbolsFile = ./keyboard/symbols/real-prog-dvorak.xkb;
  };

  # Configure keymap in X11
  services.xserver = {
    autoRepeatDelay = 200;
    autoRepeatInterval = 25;
    layout = "real-prog-dvorak";
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  services.qemuGuest.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.porebski = {
    isNormalUser = true;
    description = "Porebski";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    packages = with pkgs; [
      firefox
      keepassxc
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    dejavu_fonts
    liberation_ttf
    source-code-pro
    siji
    nerdfonts
    powerline-fonts
    powerline-symbols
    font-awesome
    line-awesome
    material-icons
    material-symbols
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system call monitoring
    arandr
    autorandr
    bat
    btop # replacement of htop/nmon
    cowsay
    eza
    file
    fish
    fzf
    gawk
    git
    gnupg
    gnused
    gnutar
    htop
    iftop # network monitoring
    iotop # io monitoring
    killall
    lsof # list open files
    ltrace # library call monitoring
    ripgrep
    rsync
    strace # system call monitoring
    tree
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    which
    xorg.xbacklight
    xorg.xmodmap
    zstd
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
