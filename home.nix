{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kyee";
  home.homeDirectory = "/home/kyee";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
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

    #custom
    pywal16
    pywalfox-native
  ];

  home.stateVersion = "25.11";

  services.udiskie.enable = true;

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };

  programs.vscode = {
    enable = true;
  };

  # input methods
  i18n.inputMethod = {
    enable = true;

    type = "fcitx5"; 

    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-chinese-addons
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "kyee";
        email = "chaojianbili@outlook.com";
      };
    };
  };

  programs.bash = {
    
  };
}
