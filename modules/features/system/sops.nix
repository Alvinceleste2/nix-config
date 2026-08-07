{ inputs, ... }:
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {

      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

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

  flake.modules.homeManager.sops =
    { config, ... }:
    {
      sops = {
        defaultSopsFile = "${inputs.nix-secrets}/secrets.yaml";

        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
}
