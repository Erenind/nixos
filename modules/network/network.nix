{pkgs,...}:
{
  # network
  networking = {
    hostName = "Ththree";
    networkmanager.enable = true;
    
    # proxy
    proxy = {
      default = "http://127.0.0.1:7897";
      httpProxy = "http://127.0.0.1:7897";
      httpsProxy = "http://127.0.0.1:7897";
    };

    # firewall.allowedTCPPorts = [ 10810 ];
  }; 

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # mirror
   nix.settings.substituters = [
     "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
     "https://mirrors.ustc.edu.cn/nix-channels/store"
     "https://cache.nixos.org"
  ];

  # systemd
  systemd.services.nix-daemon.environment = {
    http_proxy = "http://127.0.0.1:7897";
    https_proxy = "http://127.0.0.1:7897";
  };

  environment.systemPackages = with pkgs; [
    clash-verge-rev
    v2rayn
    xray
  ];
}
