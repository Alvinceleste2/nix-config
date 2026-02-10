{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python314

    postgresql
    postgresql.pg_config

    typst
    tinymist
    websocat
  ];

  services.postgresql = {
    enable = true;
  };
}
