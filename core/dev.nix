{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python312

    postgresql
    postgresql.pg_config

    typst
    tinymist
    websocat

    nodejs_24
  ];

  services.postgresql = {
    enable = true;
  };
}
