let
  nonfinite = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN1FEtYVAP1ZxuvBuW+OvvTyYztsVuHwAQw3Va4jDqtt";
  users = [ nonfinite ];

  cardamom = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILmIKj59zeVYsTpBwEiYMH2++qfOdowWq4h1DJbUFT0t";
  systems = [ cardamom ];
in
{
  "wifi-home.nmconnection.age".publicKeys = users ++ systems;
}
