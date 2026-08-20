{ self, inputs, ... }: {

    flake.nixosModules.Docker = { config, pkgs, lib, ... }:
    {
        virtualisation.docker = {
            enable = true;
            setSocketVariable = true;
        };
    };
}
