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

      globals = {
        spell_enabled = true;
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
          key = "<leader>ñ";
          action = "<cmd>set spell!<CR>";
          options = {
            desc = "Toggle spelling";
            silent = true;
          };
        }
      ];
    };
  };

  flake.modules.homeManager.neovimKeymaps = {

  };
}
