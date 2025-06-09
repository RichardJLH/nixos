{
  config,
  pkgs,
  nixvim,
  ...
}: {
  imports = [nixvim.homeManagerModules.nixvim];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

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

    # remap
    globals.mapleader = " ";

    keymaps = [
      # Colemak swaps
      {
        mode = "";
        key = ";";
        action = ":";
      }
      {
        mode = "";
        key = ":";
        action = ";";
      }

      # Navigation remaps (letter swaps)
      {
        mode = "";
        key = "n";
        action = "j";
      }
      {
        mode = "";
        key = "j";
        action = "n";
      }

      {
        mode = "";
        key = "N";
        action = "J";
      }
      {
        mode = "";
        key = "J";
        action = "N";
      }

      {
        mode = "";
        key = "e";
        action = "k";
      }
      {
        mode = "";
        key = "k";
        action = "e";
      }

      {
        mode = "";
        key = "E";
        action = "K";
      }
      {
        mode = "";
        key = "K";
        action = "E";
      }

      {
        mode = "";
        key = "i";
        action = "h";
      }
      {
        mode = "";
        key = "h";
        action = "i";
      }

      {
        mode = "";
        key = "I";
        action = "H";
      }
      {
        mode = "";
        key = "H";
        action = "I";
      }

      {
        mode = "";
        key = "o";
        action = "l";
      }
      {
        mode = "";
        key = "l";
        action = "o";
      }

      {
        mode = "";
        key = "O";
        action = "L";
      }
      {
        mode = "";
        key = "L";
        action = "O";
      }

      # Control key remaps
      {
        mode = "";
        key = "<C-n>";
        action = "<C-e>";
      }
      {
        mode = "";
        key = "<C-e>";
        action = "<C-y>";
      }
      {
        mode = "";
        key = "<C-i>";
        action = "zh";
      }
      {
        mode = "";
        key = "<C-o>";
        action = "zl";
      }

      # Visual mode line movement
      {
        mode = "v";
        key = "N";
        action = ":m '>+1<CR>gv=gv";
      }
      {
        mode = "v";
        key = "E";
        action = ":m '<-2<CR>gv=gv";
      }

      # Normal mode remaps
      {
        mode = "n";
        key = "N";
        action = "mzJ`z";
      }
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "n";
        key = "j";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "J";
        action = "Nzzzv";
      }

      # Diagnostics
      {
        mode = "";
        key = "[a";
        action.__raw = "vim.diagnostic.goto_prev";
      }
      {
        mode = "";
        key = "]a";
        action.__raw = "vim.diagnostic.goto_next";
      }

      # Text yank/delete
      {
        mode = "";
        key = "<leader>ty";
        action = "\"+y\"";
      }
      {
        mode = "";
        key = "<leader>tY";
        action = "\"+Y\"";
      }
      {
        mode = "";
        key = "<leader>td";
        action = "\"_d\"";
      }
      {
        mode = "";
        key = "<leader>tD";
        action = "\"_D\"";
      }
      {
        mode = "x";
        key = "<leader>tp";
        action = "\"_dP\"";
      }

      # Search/replace current word
      {
        mode = "n";
        key = "<leader>ts";
        action = ":%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>";
      }

      # File commands
      {
        mode = "n";
        key = "<leader>fw";
        action = "<cmd>w<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fa";
        action = "<cmd>wa<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fx";
        action = "<cmd>x<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fz";
        action = "<cmd>xa<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>fq";
        action = "<cmd>q<cr>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>ff";
        action.__raw = "function() require('conform').format() end";
      }

      {
        mode = "n";
        key = "<leader>gv";
        action = "<cmd>vsplit<cr>gd";
        options.silent = true;
      }

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
      {
        event = ["TextYankPost"];
        callback.__raw = ''function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 } end'';
      }
      {
        event = ["BufWritePre"];
        callback.__raw = "vim.lsp.buf.format";
      }
    ];

    plugins = {
      lsp.enable = true;
      oil.enable = true;
      lualine.enable = true;

      treesitter = {
        enable = true;
        settings = {
          auto_install = true;
          highlight.enable = true;
          indent.enable = true;
        };
        folding = true;
      };

      fzf-lua = {
        enable = true;
        keymaps = {
          "<leader>pf" = "files";
          "<leader>ph" = "files";
          "<leader>ps" = "live_grep";
        };
      };
      conform-nvim = {
        enable = true;
        autoLoad = true;
        settings = {
          format_on_save = ''
            function(bufnr)
              if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
              end

              -- if slow_format_filetypes[vim.bo[bufnr].filetype] then
              --   return
              -- end

              local function on_format(err)
                if err and err:match("timeout$") then
                  slow_format_filetypes[vim.bo[bufnr].filetype] = true
                end
              end

              return { timeout_ms = 200, lsp_fallback = true }, on_format
             end
          '';

          formatters_by_ft = {
            nix = ["alejandra"];
          };
        };
      };
    };

    extraConfigLua = ''require("fzf-lua").register_ui_select()'';

    lsp = {
      keymaps = [
        {
          key = "<leader>la";
          lspBufAction = "code_action";
        }
        {
          key = "<leader>lc";
          lspBufAction = "references";
        }
        {
          key = "<leader>ld";
          lspBufAction = "definition";
        }
        {
          key = "<leader>li";
          lspBufAction = "implementation";
        }
        {
          key = "<leader>lh";
          lspBufAction = "hover";
        }
        {
          key = "<leader>lr";
          lspBufAction = "rename";
        }
        {
          key = "<leader>lt";
          lspBufAction = "type_definition";
        }
      ];
      inlayHints.enable = true;
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

  home.packages = with pkgs; [gcc alejandra];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases.e = "nvim";
}
