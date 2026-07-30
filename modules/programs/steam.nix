{ self, inputs, ... }: {

    flake.nixosModules.steam = { config, lib, pkgs, ... }:

    {

        nixpkgs.config.allowUnfree = true;

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
            dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
            localNetworkGameTransfers.openFirewall = false; # Open ports in the firewall for Steam Local Network Game Transfers
        };

        environment.systemPackages = with pkgs; [
        protonup-ng
        mangohud
        r2modman
        ckan
        ];

        environment.sessionVariables = {
            STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
        };


    };


}
