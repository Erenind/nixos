{ pkgs, ... }:

{
  # 启用 Neovim 并在系统全局安装
  programs.neovim = {
    enable = true;
    defaultEditor = true; # 设为系统默认编辑器
    viAlias = true;
    vimAlias = true;

    # 配置插件（包含 Lua 插件和普通插件）
    configure = {
      customRC = ''
        lua << EOF
            ${builtins.readFile ./options.lua}
            ${builtins.readFile ./transparency.lua}
	EOF
      '';
      
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          vim-nix
          telescope-nvim
          nvim-treesitter.withAllGrammars
        ];
      };
    };
  };

  # 确保 root 用户的系统环境变量能直接识别并加载对应配置
  environment.variables = {
    EDITOR = "nvim";
  };
}

