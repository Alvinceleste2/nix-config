{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lazygit
    python312
    dos2unix
    gnumake

    postgresql
    postgresql.pg_config

    typst
    tinymist
    websocat

    # PSI
    nodejs_24
    cypress
    dbeaver-bin
  ];

  services.postgresql = {
    enable = true;
  };
}
