{ self, inputs, ... }: {

    flake.nixosModules.virtualiztionPrograms = { config, lib, pkgs, ... }:
    {

        environment.systemPackages = with pkgs; [
        lutris
        bottles
        distrobox
        boxbuddy
        ];

    };
}
