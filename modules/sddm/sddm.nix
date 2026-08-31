{pkgs, ...}:
let
  sddm-astronaut = (pkgs.sddm-astronaut.override {
    embeddedTheme = "cyberpunk";  # or any other theme
    themeConfig = {
      # Customize colors and settings
      # ... other theme configuration options
    };
  }).overrideAttrs (oldAttrs: {
    # Optional: Inject custom background image
    installPhase = oldAttrs.installPhase + ''
      chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
    '';
  });
in
{
  environment.systemPackages = [ sddm-astronaut ];
  
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia # Required for video backgrounds/audio
    ];
    theme = "sddm-astronaut-theme";
  };
}
