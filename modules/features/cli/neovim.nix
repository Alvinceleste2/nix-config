{ inputs, self, ... }:
{
  flake.modules.nixos.neovim = {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  flake.modules.homeManager.nixvim = {
    imports = [
      inputs.nixvim.homeModules.nixvim
      self.modules.homeManager.nixvimOptions
      self.modules.homeManager.nixvimSpell
      self.modules.homeManager.nixvimKeymaps
      self.modules.homeManager.nixvimLsp
      self.modules.homeManager.nixvimFormat
      self.modules.homeManager.nixvimCompletions
      self.modules.homeManager.nixvimColorscheme

      self.modules.homeManager.nixvimPluginTreesitter
      self.modules.homeManager.nixvimPluginSnacks
      self.modules.homeManager.nixvimPluginCursorline
      self.modules.homeManager.nixvimPluginNeogen
      self.modules.homeManager.nixvimPluginAutopairs
      self.modules.homeManager.nixvimPluginColorizer
      self.modules.homeManager.nixvimPluginTodocomments
      self.modules.homeManager.nixvimPluginLualine
    ];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };
    };
  };

  flake.modules.homeManager.nixvimOptions = {
    programs.nixvim = {
      opts = {
        number = true;
        relativenumber = true;
        wrap = true;

        tabstop = 2;
        shiftwidth = 2;
        softtabstop = 0;
        expandtab = true;
        autoindent = true;

        scrolloff = 5;
        foldmethod = "marker";
        signcolumn = "yes";
        cmdheight = 0;
        hidden = true;

        fileencoding = "utf-8";
        termguicolors = true;

        cursorline = true;
        cursorcolumn = false;

        ignorecase = true;
        smartcase = true;

        updatetime = 100;

        mouse = "a";
        mousemodel = "extend";

        background = "dark";
        backspace = "indent,eol,start";

        splitright = true;
        splitbelow = true;

        backup = false;
        writebackup = false;
        undofile = true;

        showmatch = true;
        matchtime = 1;

        # Folds
        foldlevel = 99;
        foldcolumn = "1";
        foldenable = true;
        foldlevelstart = -1;
        fillchars = {
          horiz = "━";
          horizup = "┻";
          horizdown = "┳";
          vert = "┃";
          vertleft = "┫";
          vertright = "┣";
          verthoriz = "╋";

          eob = " ";
          diff = "╱";

          fold = " ";
          foldopen = "";
          foldclose = "";

          msgsep = "‾";
        };
      };
    };
  };

  flake.modules.homeManager.nixvimSpell = {
    programs.nixvim = {
      opts = {
        spelllang = [
          "es_es"
          "en_us"
        ];
        spell = false;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>st";
          action = "<cmd>set spell!<CR>";
          options = {
            desc = "Toggle Spellcheck";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>sf";
          action = "z=";
          options.desc = "Fix / Suggestions for word";
        }
        {
          mode = "n";
          key = "<leader>sa";
          action = "zg";
          options.desc = "Add word to dictionary";
        }
        {
          mode = "n";
          key = "<leader>sr";
          action = "zw";
          options.desc = "Remove / Mark word as wrong";
        }
        {
          mode = "n";
          key = "]s";
          action = "]s";
          options.desc = "Next misspelled word";
        }
        {
          mode = "n";
          key = "[s";
          action = "[s";
          options.desc = "Previous misspelled word";
        }
      ];
    };
  };

  flake.modules.homeManager.nixvimKeymaps = {
    programs.nixvim.keymaps = [
      # --- Splits ---
      {
        mode = "n";
        key = "<leader>sv";
        action = "<C-w>v";
        options.desc = "Split window vertically";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<C-w>s";
        options.desc = "Split window horizontally";
      }

      # --- Tabs ---
      {
        mode = "n";
        key = "<leader>to";
        action = "<cmd>tabnew<CR>";
        options.desc = "Open new tab";
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = "<cmd>tabclose<CR>";
        options.desc = "Close current tab";
      }
      {
        mode = "n";
        key = "]t";
        action = "<cmd>tabn<CR>";
        options.desc = "Go to next tab";
      }
      {
        mode = "n";
        key = "[t";
        action = "<cmd>tabp<CR>";
        options.desc = "Go to previous tab";
      }
      {
        mode = "n";
        key = "<leader>tf";
        action = "<cmd>tabnew %<CR>";
        options.desc = "Open current buffer in new tab";
      }

      # --- Move lines around with ALT + {j,k} ---
      {
        mode = "n";
        key = "<A-j>";
        action = ":m +1<CR>==";
        options.desc = "Move down";
      }
      {
        mode = "n";
        key = "<A-k>";
        action = ":m -2<CR>==";
        options.desc = "Move up";
      }
      {
        mode = "i";
        key = "<A-j>";
        action = "<ESC>:m .+1<CR>==gi";
        options.desc = "Move down";
      }
      {
        mode = "i";
        key = "<A-k>";
        action = "<ESC>:m .-2<CR>==gi";
        options.desc = "Move up";
      }
      {
        mode = "v";
        key = "<A-j>";
        action = ":m '>+1<CR>gv=gv";
        options.desc = "Move down";
      }
      {
        mode = "v";
        key = "<A-k>";
        action = ":m '<-2<CR>gv=gv";
        options.desc = "Move up";
      }

      # --- Alias awkward movement keys ---
      {
        mode = [
          "n"
          "v"
        ];
        key = "K";
        action = "{";
        options.desc = "Go to paragraph backward";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "J";
        action = "}";
        options.desc = "Go to paragraph forward";
      }

      # --- Window navigation ---
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Left window";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Down window";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Up window";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Right window";
      }

      # --- Use Tab in normal and visual modes ---
      {
        mode = "n";
        key = "<Tab>";
        action = ">>";
        options.desc = "Indent right";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = "<<";
        options.desc = "Indent left";
      }
      {
        mode = "v";
        key = "<Tab>";
        action = ">gv";
        options.desc = "Indent right";
      }
      {
        mode = "v";
        key = "<S-Tab>";
        action = "<gv";
        options.desc = "Indent left";
      }
    ];
  };

  flake.modules.homeManager.nixvimLsp = {
    programs.nixvim = {
      extraConfigLua = ''
        vim.diagnostic.config({
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN]  = " ",
              [vim.diagnostic.severity.INFO]  = " ",
              [vim.diagnostic.severity.HINT]  = "󰌵 ",
            },
          },
        })
      '';

      plugins.lsp = {
        enable = true;

        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          # pyright.enable = true;
          # clangd.enable = true;
        };

        keymaps.lspBuf = {
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "<leader>k" = "hover";
          "<leader>gd" = "definition";
        };

        keymaps.diagnostic = {
          "<leader>cd" = "open_float";
          "[d" = "goto_prev";
          "]d" = "goto_next";
        };
      };

      plugins.nvim-lightbulb.enable = true; # Code actions bulb
      plugins.fidget.enable = true; # Lsp status at start
    };
  };

  flake.modules.homeManager.nixvimFormat =
    { pkgs, ... }:
    {
      programs.nixvim = {
        extraPackages = with pkgs; [
          nixfmt
          stylua
          # clang-format
          # black
          # typstyle
          # prettier
        ];

        plugins.conform-nvim = {
          enable = true;

          settings = {
            format_on_save = {
              timeout_ms = 500;
              lsp_fallback = true;
            };

            formatters_by_ft = {
              nix = [ "nixfmt" ];
              lua = [ "stylua" ];
            };
          };
        };
      };
    };

  flake.modules.homeManager.nixvimCompletions = {
    programs.nixvim = {
      plugins.cmp = {
        enable = true;

        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };

      plugins.luasnip.enable = true;
      plugins.lspkind.enable = true; # Completion icons
    };
  };

  flake.modules.homeManager.nixvimColorscheme = {
    programs.nixvim = {
      colorschemes.rose-pine = {
        enable = true;

        settings = {
          variant = "main";

          styles = {
            bold = true;
            italic = true;
            transparency = false;
          };
        };
      };
    };
  };

  flake.modules.homeManager.nixvimPluginTreesitter = {
    programs.nixvim = {
      plugins.treesitter = {
        enable = true;

        settings = {
          highlight.enable = true;
          indent.enable = true;

          ensureInstalled = [
            "nix"
            "lua"
          ];
        };
      };
    };
  };

  flake.modules.homeManager.nixvimPluginGitsigns = {
    programs.nixvim = {
      plugins.gitsigns = {
        enable = true;

        settings = {
          signs = {
            add = {
              text = "┃";
            };
            change = {
              text = "┃";
            };
            delete = {
              text = "┃";
            };
            topdelete = {
              text = "┃";
            };
            changedelete = {
              text = "┃";
            };
            untracked = {
              text = "┃";
            };
          };
        };
      };
    };
  };

  flake.modules.homeManager.nixvimPluginSnacks =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        lazygit
      ];

      imports = [
        self.modules.homeManager.nixvimPluginGitsigns
      ];

      programs.nixvim = {
        plugins.web-devicons.enable = true;

        plugins.snacks = {
          enable = true;

          settings = {
            bigfile.enabled = true;

            dashboard = {
              enabled = true;

              sections = {
                # raw is necessary to avoid overriding between imports
                __raw = ''
                  {
                    { section = "header" },
                    {
                      section = "keys",
                      gap = 1,
                      padding = 1,
                    },
                  }
                '';
              };
            };

            explorer = {
              enabled = true;
              # replace_netrw = true;
              auto_close = true;
            };

            image.enabled = true;

            indent.enabled = true;

            input.enabled = true;

            lazygit.enabled = true;

            notifier = {
              enabled = true;
              timeout = 3000;
              style = "compact";
            };

            picker = {
              enabled = true;

              sources = {
                files = {
                  hidden = true;
                };
                grep = {
                  hidden = true;
                };
                explorer = {
                  hidden = true;
                };
              };
            };

            scope.enabled = true;

            scroll.enabled = true;

            # statuscolumn.enabled = true;
          };
        };

        keymaps = [
          # Lazygit
          {
            mode = "n";
            key = "<leader>lg";
            action = {
              __raw = "function() Snacks.lazygit() end";
            };
            options.desc = "Toggle LazyGit";
          }

          # Explorer
          {
            mode = "n";
            key = "<leader>e";
            action = {
              __raw = "function() Snacks.explorer() end";
            };
            options.desc = "Toggle Snacks Explorer";
          }

          # Notifier
          {
            mode = "n";
            key = "<leader>nq";
            action = {
              __raw = "function() Snacks.notifier.hide() end";
            };
            options.desc = "Dismiss Notification";
          }
          {
            mode = "n";
            key = "<leader>nh";
            action = {
              __raw = "function() Snacks.notifier.show_history() end";
            };
            options.desc = "Notification History";
          }

          # Picker
          {
            mode = "n";
            key = "<leader><space>";
            action = {
              __raw = "function() Snacks.picker.smart() end";
            };
            options.desc = "Smart Find Files";
          }
          {
            mode = "n";
            key = "<leader>sd";
            action = {
              __raw = "function() Snacks.picker.diagnostics() end";
            };
            options.desc = "Diagnostics and Errors (LSP)";
          }
          {
            mode = "n";
            key = "<leader>ss";
            action = {
              __raw = "function() Snacks.picker.lsp_symbols() end";
            };
            options.desc = "Document Symbols (Functions, Classes)";
          }
          {
            mode = "n";
            key = "<leader>sk";
            action = {
              __raw = "function() Snacks.picker.keymaps() end";
            };
            options.desc = "Search Keymaps";
          }
        ];
      };
    };

  flake.modules.homeManager.nixvimPluginCursorline = {
    programs.nixvim = {
      plugins.cursorline = {
        enable = true;

        settings = {
          cursorline = {
            enable = true;
            timeout = 1000;
            number = false;
          };
          cursorword = {
            enable = true;
            min_length = 3;
            hl = {
              underline = true;
            };
          };
        };
      };
    };
  };

  flake.modules.homeManager.nixvimPluginNeogen = {
    programs.nixvim = {
      plugins.neogen = {
        enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>ng";
          action = {
            __raw = "function() require('neogen').generate() end";
          };
          options.desc = "Generate Annotation (Neogen)";
        }
      ];
    };
  };

  flake.modules.homeManager.nixvimPluginAutopairs = {
    programs.nixvim = {
      plugins.nvim-autopairs = {
        enable = true;
      };
    };
  };

  flake.modules.homeManager.nixvimPluginColorizer = {
    programs.nixvim = {
      plugins.colorizer = {
        enable = true;

        settings = {
          filetypes = [ "*" ];
          user_default_options = {
            mode = "virtualtext"; # Modes: "background", "foreground", "virtualtext"
            RGB = true;
            RRGGBB = true;
            names = true;
            # RRGGBBAA = true;
            # AARRGGBB = true;
            # rgb_fn = false; # CSS rgb() and rgba()
            # hsl_fn = false; # CSS hsl() and hsla()
            # tailwind = false;
          };
        };
      };
    };
  };

  flake.modules.homeManager.nixvimPluginTodocomments = {
    imports = [
      self.modules.homeManager.nixvimPluginSnacks
    ];

    programs.nixvim = {
      plugins.todo-comments = {
        enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "<leader>st";
          action = {
            __raw = "function() Snacks.picker.todo_comments() end";
          };
          options.desc = "Search TODOs (Snacks Picker)";
        }
      ];
    };
  };

  flake.modules.homeManager.nixvimPluginLualine = { lib, ... }: {
    programs.nixvim = {
      plugins.lualine = {
        enable = true;

        settings = {
          options = {
            theme = "auto";
            component_separators = "|";
            section_separators = {
              left = "";
              right = "";
            };
            disabled_filetypes = {
              statusline = [ "snacks_layout_box" ];
            };
          };

          sections = {
            lualine_a = [
              {
                __unkeyed-1 = "mode";
                separator = {
                  left = "";
                };
                right_padding = 2;
              }
            ];
            lualine_b = [
              "filename"
              "branch"
            ];
            lualine_c = [
              {
                __unkeyed-1 = "diagnostics";
                symbols = {
                  error = " ";
                  warn = " ";
                  info = " ";
                  hint = "󰌵 ";
                };
              }
            ];
            lualine_x = [
              "encoding"
              "fileformat"
            ];
            lualine_y = [
              "filetype"
              "progress"
            ];
            lualine_z = [
              {
                __unkeyed-1 = "location";
                separator = {
                  right = "";
                };
                left_padding = 2;
              }
            ];
          };

          inactive_sections = {
            lualine_a = [ "filename" ];
            lualine_b = [ ];
            lualine_c = [ ];
            lualine_x = [ ];
            lualine_y = [ "filetype" ];
            lualine_z = [ ];
          };

          tabline = { };
          extensions = [ ];
        };
      };
    };
  };
}
