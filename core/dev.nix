{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    typst
    python314

    postgresql
    postgresql.pg_config

    virtualbox
  ];
}
