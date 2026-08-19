{ self, inputs, ... }: {

    flake.nixosModules.Docker = { config, pkgs, lib, ... }:
    {
        virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
        };
    };
}
