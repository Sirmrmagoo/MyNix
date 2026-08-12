{ self, inputs, ... }:  {

    flake.nixosModules.garbageSettings = { config, lib, pkgs, ... }:    {
        nix.gc.automatic = true;
        nix.gc.dates = "daily";
        nix.gc.options = "--delete-older-than 3d";
        nix.settings.auto-optimise-store = true;

    };
}


