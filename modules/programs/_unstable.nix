{ self, inputs, ... }: {
  perSystem = { nixpkgs-unstable, ... }: {
    packages.fetch = inputs.nixpkgs-unstable.fetch
      inherit nixpkgs-unstable; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
  };
}
