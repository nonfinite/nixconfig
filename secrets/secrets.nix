let
  pk = import ../pub-keys.nix;
  users = [ pk.users.nonfinite ];

  systems = [ pk.systems.cardamom ];
in
{
  "wifi-home.nmconnection.age".publicKeys = users ++ systems;
}
