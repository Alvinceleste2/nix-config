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

    # PSI & SI2
    nodejs_24
    cypress
    dbeaver-bin

    jmeter
    nmon
  ];

  services.postgresql = {
    enable = true;
  };
}
