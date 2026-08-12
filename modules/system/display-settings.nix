{ self, inputs, ... }:  {

    flake.nixosModules.displaySettings = { config, lib, pkgs, ... }:    {

        services.xserver = {
            enable = true;
            videoDrivers = [ "amdgpu" ];
            xkb = {
                layout = "us";
                variant = "";
            };
        };

        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

        hardware.graphics = {
            enable = true;
            enable32Bit = true;
            extraPackages = with pkgs; [
                mesa.opencl # Enables Rusticl (OpenCL) support
            ];
        };

        environment.variables = {
            RUSTICL_ENABLE = "radeonsi";
        };
    };
}



