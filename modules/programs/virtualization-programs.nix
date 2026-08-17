{ self, inputs, ... }: {

    flake.nixosModules.virtualiztionPrograms = { config, lib, pkgs, ... }:
    {

        environment.systemPackages = with pkgs; [
        lutris
        distrobox
        boxbuddy
        wineWow64Packages.stable
        wineWow64Packages.waylandFull
        winetricks
        ];

    };
}
