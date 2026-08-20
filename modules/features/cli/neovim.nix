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
        cmdheight = 1;
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
}
