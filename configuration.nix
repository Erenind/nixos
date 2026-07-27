{ config, lib, pkgs, ... }:

{
  # EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # 启用 RealtimeKit 服务，为音频应用提供实时调度权限
  security.rtkit.enable = true;

  # time zone
  time.timeZone = "Asia/Shanghai";

  
  # network
  networking = {
    hostName = "Ththree";
    useDHCP = true;
    wireless = {
	enable = true;
	networks = {
	    "CMCC-vjwbb".psk = "658bgj5ce76szq9";
	};
    };
    
    # proxy
    proxy = {
      default = "http://127.0.0.1:10808";
      httpProxy = "http://127.0.0.1:10808";
      httpsProxy = "http://127.0.0.1:10808";
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
 
  # sddm & auto login 
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
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

  # steam
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };


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
      "networkmanager"
    ];
  };

  # pkgs
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    yazi
    waypaper
    rofi
    vscode
    obsidian
    waybar
    fastfetch
    lolcat
    wl-clipboard
    adwaita-icon-theme
    neovide
    ripgrep
    ffmpeg
    opencode

    hyprpaper
    hyprpicker
    hyprlauncher
    hypridle
    hyprlock
    hyprsysteminfo
    hyprsunset
    hyprcursor



    htop
    fortune
    bibata-cursors
    brightnessctl
    hyprshot
    hyprls
    killall
    fzf
    nautilus
    tree
    python315
    steam-run

    # quickshell and Qt support
    quickshell
    qt6.qtsvg
    qt6.qtimageformats
    qt6.qtmultimedia
    nerd-fonts.fira-code
    qmlformat

    #custom
    pywal16
    pywalfox-native

    vscode

    v2rayn
    xray
    sing-box
  ];

  # unfree config
  nixpkgs.config.allowUnfree = true;

  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # mirror
  # nix.settings.substituters = [
    # "https://mirrors.ustc.edu.cn/nix-channels/store"
    # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  # ];



  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # systemd
  systemd.services.nix-daemon.environment = {
    http_proxy = "http://127.0.0.1:10808";
    https_proxy = "http://127.0.0.1:10808";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };



  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
