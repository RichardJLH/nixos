{ inputs, config, pkgs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  programs.nixvim = {
    enable = true;

    # set
    opts = {
      number = true;
      relativenumber = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      smartindent = true;
      wrap = false;

      swapfile = false;
      backup = false;
      undodir = "${config.home.homeDirectory}/.local/share/history/vim";
      undofile = true;

      hlsearch = true;
      incsearch = true;

      termguicolors = true;

      scrolloff = 8;

      updatetime = 50;
      timeout = false;
    };

    colorschemes.dracula-nvim.enable = true;


    # remap
    globals.mapleader = " ";

    keymaps = [
      # Colemak swaps
      { mode = ""; key = ";"; action = ":"; }
      { mode = ""; key = ":"; action = ";"; }

      # Navigation remaps (letter swaps)
      { mode = ""; key = "n"; action = "j"; }
      { mode = ""; key = "j"; action = "n"; }

      { mode = ""; key = "N"; action = "J"; }
      { mode = ""; key = "J"; action = "N"; }

      { mode = ""; key = "e"; action = "k"; }
      { mode = ""; key = "k"; action = "e"; }

      { mode = ""; key = "E"; action = "K"; }
      { mode = ""; key = "K"; action = "E"; }

      { mode = ""; key = "i"; action = "h"; }
      { mode = ""; key = "h"; action = "i"; }

      { mode = ""; key = "I"; action = "H"; }
      { mode = ""; key = "H"; action = "I"; }

      { mode = ""; key = "o"; action = "l"; }
      { mode = ""; key = "l"; action = "o"; }

      { mode = ""; key = "O"; action = "L"; }
      { mode = ""; key = "L"; action = "O"; }

      # Control key remaps
      { mode = ""; key = "<C-n>"; action = "<C-e>"; }
      { mode = ""; key = "<C-e>"; action = "<C-y>"; }
      { mode = ""; key = "<C-i>"; action = "zh"; }
      { mode = ""; key = "<C-o>"; action = "zl"; }

      # Visual mode line movement
      { mode = "v"; key = "N"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "E"; action = ":m '<-2<CR>gv=gv"; }

      # Normal mode remaps
      { mode = "n"; key = "N"; action = "mzJ`z"; }
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
      { mode = "n"; key = "j"; action = "nzzzv"; }
      { mode = "n"; key = "J"; action = "Nzzzv"; }

      # Diagnostics
      { mode = ""; key = "[a"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; }
      { mode = ""; key = "]a"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; }

      # Text yank/delete
      { mode = ""; key = "<leader>ty"; action = "\"+y\""; }
      { mode = ""; key = "<leader>tY"; action = "\"+Y\""; }
      { mode = ""; key = "<leader>td"; action = "\"_d\""; }
      { mode = ""; key = "<leader>tD"; action = "\"_D\""; }
      { mode = "x"; key = "<leader>tp"; action = "\"_dP\""; }

      # Search/replace current word
      {
        mode = "n";
        key = "<leader>ts";
        action = ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>";
      }

      # File commands
      { mode = "n"; key = "<leader>fw"; action = "<cmd>w<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fa"; action = "<cmd>wa<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fx"; action = "<cmd>x<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fz"; action = "<cmd>xa<cr>"; options.silent = true; }
      { mode = "n"; key = "<leader>fq"; action = "<cmd>q<cr>"; options.silent = true; }

      { mode = "n"; key = "<leader>gv"; action = "<cmd>vsplit<cr>gd"; options.silent = true; }

      {
        key = "<leader>po";
        action = "<cmd>Oil<cr>";
        options = {
          desc = "Manipulate directory contents";
          silent = true;
        };
        mode = "n";
      }
    ];

    autoCmd = [
      { event = [ "TextYankPost" ]; callback.__raw = ''function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 } end''; }
      { event = [ "BufWritePre" ]; callback.__raw = "vim.lsp.buf.format"; }
    ];

    plugins = {
      oil.enable = true;
      lualine.enable = true;

      treesitter = {
        enable = true;
        settings.auto_install = true;
      };

	  fzf-lua = {
        enable = true;
        keymaps = {
          "<leader>pf" = "files";
          "<leader>ph" = "files";
          "<leader>ps" = "live_grep";
        };
      };
    };

	extraConfigLua = ''require("fzf-lua").register_ui_select()'';

    plugins.lsp = {
      enable = true;
	  inlayHints = true;
      servers = {
        nil_ls.enable = true;
        jdtls.enable = true;
        # rust_analyzer.enable = true;
      };
    };


    # plugins
    # plugins.alpha = {
    #   enable = true;
      # layout = [
      #   {
      #     type = "text";
      #     opts = {
      #       hl = "Type";
      #       position = "center";
      #     };
      #     val = [
      #         "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
      #         "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
      #         "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
      #         "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
      #         "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
      #         "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
      #     ];
      #   }
      #
        # {
        #   type = "group";
        #   val = [
        #     {
        #       type = "button";
        #       val = "󰈞 Find Files";
        #       opts.shortcut = "f";
        #       on_press. __raw = ''function() require("fzf-lua").files({ cmd = "fd --type f" }) end'';
        #     }
        #     {
        #       type = "button";
        #       val = "󰈞 All Files";
        #       opts.shortcut = "a";
        #       on_press. __raw = ''function() require("fzf-lua").files() end'';
        #     }
        #     {
        #       type = "button";
        #       val = "  Recent Files";
        #       opts.shortcut = "r";
        #       on_press. __raw = ''function() require("fzf-lua").oldfiles() end'';
        #     }
        #     {
        #       type = "button";
        #       val = "  Manage Files";
        #       opts.shortcut = "o";
        #       on_press. __raw = ''function() require("oil").open() end'';
        #     }
        #     {
        #       type = "button";
        #       val = "  create new file";
        #       opts.shortcut = "n";
        #       on_press. __raw = "<cmd>ene <bar> startinsert <cr>";
        #     }
        #     {
        #       type = "button";
        #       val = "  Find Text";
        #       opts.shortcut = "t";
        #       on_press. __raw = ''function() require("fzf-lua").live_grep() end'';
        #     }
        #     {
        #       type = "button";
        #       val = "󰗼  Quit Neovim";
        #       opts.shortcut = "q";
        #       on_press. __raw = "<cmd>qa<cr>";
        #     }
        #   ];
        # }
    # };
  };

  home.packages = [ pkgs.gcc ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nushell.shellAliases.e = "nvim";
}
