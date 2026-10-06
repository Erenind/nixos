{ config, lib, pkgs, ... }:
{
  # EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;


  # time zone
  time.timeZone = "Asia/Shanghai";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # display_manager
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.user = "kyee";
 
  # GVfs for MTP 
  services.gvfs.enable = true;

  # upower
  services.upower.enable = true;

  # browser
  programs.firefox.enable = true;

  # hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

  };

  # game
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # font
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
    enableDefaultPackages = true;
    fontconfig = {
      antialias = true;
    };
  };
  
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  services.udisks2.enable = true;

  # user account
  users.users.kyee = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "gamemode"
    ];
  };

  # pkgs
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    htop
    rofi
    awww
    waypaper
    vscode
    obsidian
    fastfetch
    wl-clipboard
    adwaita-icon-theme
    neovide
    ripgrep
    ffmpeg
    yazi
    

    hyprpaper
    hyprpicker
    hyprlauncher
    hyprsunset
    hypridle
    hyprlock
    hyprsysteminfo
    hyprcursor

    btop
    bibata-cursors
    brightnessctl
    hyprshot
    hyprls
    fzf
    nautilus
    tree
    python315

    # quickshell and Qt support
    quickshell
    qt6.qtsvg
    qt6.qtimageformats
    qt6.qtmultimedia
    nerd-fonts.fira-code

    #custom
    pywal16
    pywalfox-native

    vscode
    codex

    keepassxc

    alsa-utils
  ];

  # unfree config
  nixpkgs.config.allowUnfree = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
	      qt6Packages.fcitx5-chinese-addons
	      fcitx5-nord
      ];
    };
  };

  system.stateVersion = "25.11";
}
