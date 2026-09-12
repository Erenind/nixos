{ config, lib, pkgs, ... }:
{
  # EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # time zone
  time.timeZone = "Asia/Shanghai";

  
  # network
  networking = {
    hostName = "Ththree";
    networkmanager.enable = true;
    
    # proxy
    proxy = {
      default = "http://127.0.0.1:10808";
      httpProxy = "http://127.0.0.1:10808";
      httpsProxy = "http://127.0.0.1:10808";
    };

    firewall.allowedTCPPorts = [ 10810 ];
  };

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
  # services.xserver.xkb.options = "caps:escape";

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
    waypaper
    vscode
    obsidian
    fastfetch
    lolcat
    wl-clipboard
    adwaita-icon-theme
    neovide
    ripgrep
    ffmpeg
    opencode
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
    fortune
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
    v2rayn
    xray

    keepassxc

    alsa-utils
  ];

  # unfree config
  nixpkgs.config.allowUnfree = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # mirror
   nix.settings.substituters = [
     "https://mirrors.ustc.edu.cn/nix-channels/store"
     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
     "https://cache.nixos.org"
   ];

  # sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    wireplumber.enable = true;
  };

  # systemd
  systemd.services.nix-daemon.environment = {
    http_proxy = "http://127.0.0.1:10808";
    https_proxy = "http://127.0.0.1:10808";
  };

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
