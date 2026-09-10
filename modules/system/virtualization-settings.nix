{ self, inputs, ... }: {

    flake.nixosModules.virtualisationSettings = { config, lib, pkgs, ... }: {
        services.flatpak.enable = true;

        virtualisation.podman = {
          enable = true;
          dockerCompat = true;
        };

        virtualisation = {
          virtualbox.host.enable = true;
        };
    };
}




