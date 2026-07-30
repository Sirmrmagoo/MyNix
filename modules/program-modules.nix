{ self, inputs, ... }: {

    flake.nixosConfigurations.programModules = { config, lib, pkgs, ... }:
    {
        imports = [
            self.nixosModules.obsStudio
            self.nixosModules.virtualiztionPrograms
            self.nixosModules.steam
            self.nixosModules.programing
        ];
    };
}
