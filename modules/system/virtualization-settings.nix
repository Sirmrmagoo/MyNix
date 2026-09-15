{ self, inputs, ... }: {

    flake.nixosModules.virtualisationSettings = { config, lib, pkgs, ... }: {
        services.flatpak.enable = true;

        virtualisation = {
          virtualbox.host.enable = true;
        };
    };
}




