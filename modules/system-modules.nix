{ self, inputs, ... }: {

    flake.nixosModules.systemModules = { config, lib, pkgs, ... }:   {
        imports = [
            self.nixosModules.audioSettings
            self.nixosModules.displaySettings
            self.nixosModules.garbageSettings
            self.nixosModules.networkSettings
            self.nixosModules.timeSettings
            self.nixosModules.virtualisationSettings
        ];
    };
}
