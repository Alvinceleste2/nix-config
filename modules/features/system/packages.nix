{
  flake.modules.nixos.packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        vim
        neovim
        git
        curl
        htop
        zip
        unzip
        stow
        tree
        fastfetch
        just
      ];

      environment.sessionVariables = {
        EDITOR = "nvim";
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nixpkgs.config.allowUnfree = true;

      programs.nix-ld.enable = true;
    };
}
