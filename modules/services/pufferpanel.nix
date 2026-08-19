{ self, inputs, ... }: {
  flake.nixosModules.PufferPanel = { config, pkgs, lib, ... }: {

    virtualisation.oci-containers = {

      backend = "docker";

      containers = {

        pufferpanel = {

          image = "pufferpanel/pufferpanel:latest";

          ports = [
            "8080:8080"  # Web interface
            "5657:5657"  # SFTP
          ];

          volumes = [
            "/home/nixos/pufferpanel/data:/etc/pufferpanel"
            "/home/nixos/pufferpanel/-servers:/var/lib/pufferpanel:z"
            "/home/nixos/pufferpanel/var/run/docker.sock:/var/run/docker.sock"
          ];

          autoStart = true;
    
          extraOptions = [
            "--restart=on-failure"
          ];

        };
      };
    };  
  };
}
