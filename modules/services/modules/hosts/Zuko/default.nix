{ self, inputs, ... }:  {

  flake.nixosConfigurations.Zuko = inputs.nixpkgs.lib.nixosSystem {
    modules = [ 
      self.nixosModules.ZukoConfiguration 
    ];
  };

}
