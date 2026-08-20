{ self, inputs, ... }: {
  flake.nixosModules.PufferPanel = { config, pkgs, lib, ... }: {

    virtualisation.oci-containers = {

      backend = "docker";

      containers = {

        pufferpanel = {

          image = "pufferpanel/pufferpanel:latest";

          ports = [ 
            "0.0.0.0:8080:8080" 
            "0.0.0.0:5657:5657"
          ];

          volumes = [
            "/home/nixos/services/pufferpanel/data:/etc/pufferpanel"
            "/home/nixos/services/pufferpanel/servers:/var/lib/pufferpanel:z"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];

          autoStart = true;

        };
      };
    };  
  };
}
