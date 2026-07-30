{ self, inputs, ... }: {

    flake.nixosConfigurations.displaySettings = { config, lib, pkgs, ... }:

{

    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;


    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

};

}



