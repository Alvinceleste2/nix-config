{
  flake.modules.nixos.virtualization = {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "alvinceleste" ];
  };
}
