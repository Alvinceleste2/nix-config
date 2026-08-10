{
  flake.modules.homeManager.firefox = {
    programs.firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };
  };
}
