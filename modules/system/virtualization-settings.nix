{ self, inputs, ... }: {

    flake.nixosConfigurations.virtualisationSettings = { config, lib, pkgs, ... }:

{

  services.flatpak.enable = true;
  virtualisation.virtualbox.host.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

};


}




