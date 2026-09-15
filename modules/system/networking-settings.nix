{ self, inputs, ... }:  {

    flake.nixosModules.networkSettings = { config, lib, pkgs, ... }:    {
        networking.hostName = "sirmr-nixos";
        networking.networkmanager.enable = true;

    };
}




