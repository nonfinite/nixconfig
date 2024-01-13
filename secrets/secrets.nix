let
  pk = import ../globals/pub-keys.nix;
  users = [ pk.users.nonfinite ];

  systems = [ pk.systems.cardamom pk.systems.mizuna ];
in
{
  # edit with `agenix -e file`
  "wifi-home.nmconnection.age".publicKeys = users ++ systems;
}
