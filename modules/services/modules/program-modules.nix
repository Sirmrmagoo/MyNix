{ self, inputs, ... }: {

    flake.nixosModules.programModules = { config, lib, pkgs, ... }: {
        imports = [
            self.nixosModules.OBS
            self.nixosModules.virtualiztionPrograms
            self.nixosModules.steam
            self.nixosModules.programing
        ];
    };
}
