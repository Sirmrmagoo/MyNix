{ self, inputs, ... }: {
  flake.nixosConfigurations.Ozai = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.OzaiConfiguration
    ];
  };
}
