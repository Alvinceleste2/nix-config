{
  flake.modules.nixos.dev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gcc
        python312

        dos2unix
        gnumake

        typst
        tinymist
        websocat

        neovim
        tree-sitter
        nodejs_24
      ];
    };
}
