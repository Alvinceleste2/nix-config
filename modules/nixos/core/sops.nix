{
  config,
  pkgs,
  lib,
  inputs,
  dir,
  desc,
  ...
}:

let
  cfg = lib.attrByPath dir { } config;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options = lib.setAttrByPath dir {
    enable = lib.mkEnableOption desc;
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";
      defaultSopsFormat = "yaml";
      validateSopsFiles = false;

      age = {
        # automatically import host SSH keys as age keys
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        # this will use an age key that is expected to already be in the filesystem
        keyFile = "/var/lib/sops-nix/key.txt";
        # generate a new key if the key specified above does not exist
        generateKey = true;
      };
    };

    environment.systemPackages = with pkgs; [
      age
      sops
      mkpasswd # creation of password hashes
    ];
  };
}
