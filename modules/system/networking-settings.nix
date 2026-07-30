{ self, inputs, ... }: {

    flake.nixosConfigurations.networkSettings = { config, lib, pkgs, ... }:

{

    networking.hostName = "sirmr-nixos";
    networking.networkmanager.enable = true;

};

}




