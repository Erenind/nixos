{ config, pkgs, lib, ... }:

let
  # 配置文件与订阅存放路径
  configDir = "/etc/sing-box";
  configFile = "${configDir}/config.json";
  # 替换为你的真实订阅地址
  subUrl = "https://ejka.332324.xyz/sub?token=76222708e8fa428c337235cd742a6586&sb";


  # 统一下发的管理脚本
  proxyCtl = pkgs.writeShellApplication {
    name = "proxy-ctl";

    runtimeInputs = with pkgs; [
      curl
      jq
      systemd
    ];

    text = ''
      SERVICE_NAME="sing-box"
      CONFIG_DIR="${configDir}"
      CONFIG_FILE="${configFile}"
      SUB_URL="${subUrl}"

      usage() {
        echo "用法: proxy-ctl {update|start|stop|restart|status|logs}"
        echo "  update  - 下载最新订阅、更新配置并重启服务"
        echo "  start   - 启动代理服务"
        echo "  stop    - 暂停/停止代理服务"
        echo "  restart - 重启代理服务"
        echo "  status  - 查看服务运行状态"
        echo "  logs    - 实时查看服务日志 (例: proxy-ctl logs -n 50)"
        exit 1
      }

      if [ $# -lt 1 ]; then
        usage
      fi

      COMMAND="$1"
      shift

      case "$COMMAND" in
        update)
          echo "=== [1/3] 正在拉取最新代理配置... ==="
          mkdir -p "$CONFIG_DIR"
          
          # 下载配置到临时文件，防止下载失败损坏原配置
          TMP_FILE=$(mktemp)
          if curl -sSL -f "$SUB_URL" -o "$TMP_FILE"; then
            mv "$TMP_FILE" "$CONFIG_FILE"
            chmod 600 "$CONFIG_FILE"
            echo "=== [2/3] 配置更新成功 ==="
          else
            echo "错误: 订阅更新失败，保持现有配置不变！"
            rm -f "$TMP_FILE"
            exit 1
          fi

          echo "=== [3/3] 正在重启代理服务... ==="
          systemctl restart "$SERVICE_NAME"
          echo "=== 代理更新并重启完毕！ ==="
          ;;

        start)
          echo "正在启动 $SERVICE_NAME..."
          systemctl start "$SERVICE_NAME"
          ;;

        stop)
          echo "正在停止 $SERVICE_NAME..."
          systemctl stop "$SERVICE_NAME"
          ;;

        restart)
          echo "正在重启 $SERVICE_NAME..."
          systemctl restart "$SERVICE_NAME"
          ;;

        status)
          systemctl status "$SERVICE_NAME"
          ;;

        logs)
          journalctl -u "$SERVICE_NAME" -f "$@"
          ;;

        *)
          echo "错误: 未知指令 '$COMMAND'"
          usage
          ;;
      esac
    '';
  };
in
{
  # 1. 安装管理脚本和代理内核到系统环境
  environment.systemPackages = [
    proxyCtl
    pkgs.sing-box
  ];


  # 2. 确保配置文件目录存在
  systemd.tmpfiles.rules = [
    "d ${configDir} 0755 root root -"
  ];

  # 3. 定义 Sing-Box 后台服务
  systemd.services.sing-box = {
    description = "Sing-Box Proxy Service";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      ENABLE_DEPRECATED_LEGACY_DNS_FAKEIP_OPTIONS = "true";
    };

    serviceConfig = {
      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c ${configFile}";
      Restart = "on-failure";
      RestartSec = "5s";
      # 安全限制
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE";
    };
  };
}
