{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

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

  environment.variables = {
    EDITOR = "nvim";
  };
}

