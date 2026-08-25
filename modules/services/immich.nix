{ self, inputs, ... }:  {
  flake.nixosModules.Immich = { config, pkgs, pkgs-unstable, lib, ... }:  
  
    let
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
    in
    {
        services.immich = {
        enable = true;
        port = 2283;
        host = "0.0.0.0";
        package = pkgs-unstable.immich;
        openFirewall = true;
        database.enable = true;
        mediaLocation = "/mnt/NAS/Immich/immichLibrary";
        accelerationDevices = [ "/dev/dri/by-path/pci-0000:01:00.0-render" ];
        };

        services.immich.machine-learning.environment = {
        HF_XET_CACHE = "/var/cache/immich/huggingface-xet";
        };


        users.users."immich" = {
        home = "/var/lib/immich";
        createHome = true;
        extraGroups = [ "wheel" "video" "render" ];
        };
    
    };
}
