{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python312
    dos2unix

    postgresql
    postgresql.pg_config

    typst
    tinymist
    websocat

    # PSI
    nodejs_24
    cypress
  ];

  services.postgresql = {
    enable = true;
  };
}
