{ self, inputs, ... }: {
  flake.nixosModules.PufferPanel = { config, pkgs, lib, ... }: {

    virtualisation.oci-containers = {

      backend = "docker";

      containers = {

        pufferpanel = {

          image = "pufferpanel/pufferpanel:latest";

          ports = [ 
            "127.0.0.1:8080:8080" 
            "127.0.0.1:5657:5657" 
          ];

          volumes = [
            "/home/nixos/pufferpanel/data:/etc/pufferpanel"
            "/home/nixos/pufferpanel/servers:/var/lib/pufferpanel:z"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];

          autoStart = true;

        };
      };
    };  
  };
}
