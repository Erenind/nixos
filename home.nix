{ config, pkgs, ... }:
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "kyee";
  home.homeDirectory = "/home/kyee";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    
  ];

  home.stateVersion = "25.11";

  

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 24;
      package = pkgs.bibata-cursors;
    };
  };

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
