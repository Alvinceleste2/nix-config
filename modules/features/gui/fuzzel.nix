{
  flake.modules.homeManager.fuzzel = {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
          line-height = 20;
          width = 30;
          show-actions = false;
          exit-on-keyboard-focus-loss = false;
          fields = "name,generic,comment,categories,filename,keywords";
          terminal = "kitty";
          prompt = ''"· " '';
          layer = "overlay";
          anchor = "center";
          lines = 10;
        };

        colors = {
          background = "191724ff";
          text = "e0def4ff";
          prompt = "e0def4ff";
          placeholder = "6e6a86ff";
          input = "e0def4ff";
          match = "ebbcbaff";
          selection = "403d52ff";
          selection-text = "e0def4ff";
          selection-match = "ebbcbaff";
          counter = "f6c177ff";
          border = "ebbcbaff";
        };

        border = {
          radius = 10;
          width = 4;
        };

        dmenu = {
          exit-immediately-if-empty = true;
        };
      };
    };
  };
}
