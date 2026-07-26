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
	    local opt = vim.opt
	    opt.number = true
	    opt.expandtab = true
	    opt.shiftwidth = 4
	    opt.tabstop = 4
	    opt.smartindent = true
	    opt.cursorline = true
	    opt.termguicolors = true

	    local function apply_transparency() 
  	    local highlights = {
    	        "Normal",
    	        "NormalNC",
     	        "Comment",
    	        "Constant",
    	        "Special",
    	        "Identifier",
    	        "Statement",
    	        "PreProc",
                 "Type",
    	        "Underlined",
                "Todo",
    	        "String",
    	        "Function",
    	        "Conditional",
    	        "Repeat",
    	        "Operator",
    	        "Structure",
    	        "LineNr",
    	        "SignColumn",
    	        "CursorLine",
    	        "CursorLineNr",
    	        "StatusLine",
    	        "StatusLineNC",
    	        "EndOfBuffer",
    	        "NormalFloat", -- 浮动窗口
    	        "FloatBorder", -- 浮动窗口边框
  	    }

  	    for _, group in ipairs(highlights) do
    	        vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" })
  	    end
	    end

	    -- 创建自动命令：每当切换/加载色彩主题时，立刻剥离其背景色
	    vim.api.nvim_create_autocmd("ColorScheme", {
  	        pattern = "*",
  	        callback = apply_transparency,
	    })

	    -- 或者是手动立刻执行一次（确保如果主题已经加载也能生效）
	    apply_transparency()

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

