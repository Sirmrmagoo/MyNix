{ self, inputs, ... }:  {

    flake.nixosModules.ozaiNetworking = { config, lib, pkgs, ... }:    {
        networking.hostName = "Ozai";
        networking.networkmanager.enable = false;
        networking.defaultGateway = "192.168.68.1";
        networking.nameservers = ["1.1.1.1" "8.8.8.8"];
        networking.useDHCP = false;
        networking.interfaces.eno2 = {
            ipv4.addresses = [{
                address = "192.168.68.72";
                prefixLength = 22;
            }];
        };
    };
}




