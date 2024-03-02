{ mizuna, ... }:
let
  storage = "/enc/containers/seq";
  env = "${storage}/.env";
in
{
  virtualisation.oci-containers.containers.seq = {
    image = "docker.io/datalust/seq";
    hostname = "seq";
    user = mizuna.defaultUserGroup;
    environment = {
      ACCEPT_EULA = "y";
      SEQ_API_CANONICALURI = mizuna.urls.seq;
    };
    environmentFiles = [ env ];
    ports = [
      "${mizuna.ports.str.seq}:80"
      "${mizuna.ports.str.seqIngest}:5341"
    ];
    volumes = [
      "${storage}/data:/data"
    ];
  };
}
