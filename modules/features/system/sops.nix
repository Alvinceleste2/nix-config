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
          sshKeyPaths = [ "/home/alvinceleste/.ssh/alvinceleste" ];
          generateKey = false;
        };

        gnupg.sshKeyPaths = [ ];
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
        defaultSopsFormat = "yaml";
        validateSopsFiles = false;

        age = {
          sshKeyPaths = [ "${config.home.homeDirectory}/.ssh/alvinceleste" ];
          generateKey = false;
        };

        gnupg.sshKeyPaths = [ ];
      };
    };
}
