{
  inputs,
  ...
}:

{
  imports = [
    ./user.nix
  ];

  home-manager.users.alvinceleste = {
    imports = [
      ./home.nix
      ./secrets.nix
    ];
  };
}
