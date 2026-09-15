{ self, inputs, ... }:  {

  perSystem = { pkgs, lib, ... }: {
    
    packages.myHypr = inputs.wrapper-modules.wrappers.hyprland.wrap {
      inherit pkgs;


    };
  };





  flake.nixosModules.Hyprland = { config, pkgs, lib, ... }:  {






    programs.hyprland = {
      enable = true;
      # set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.systemPackages = [
      inputs.hyprmod.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  };
}
