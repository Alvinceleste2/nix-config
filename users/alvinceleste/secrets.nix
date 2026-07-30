{ config, inputs, ... }:

{
  sops = {
    defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "alvinceleste-github" = { };
    };
  };
}
