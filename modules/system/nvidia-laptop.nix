{ self, inputs, ... }:  {

    flake.nixosModules.NvidiaLaptop = { config, pkgs, lib, ... }:   {

        hardware.graphics.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];
        boot.kernelModules = [ "nvidia" "nvidia_drm" "nvidia_uvm" ];
        hardware.nvidia-container-toolkit.enable = true;
        
        hardware.nvidia = {
            open = true;
            modesetting.enable = true;  
        };

        hardware.nvidia.prime = {
            sync.enable = true;
            intelBusId = "PCI:0@0:2:0";
            nvidiaBusId = "PCI:1@0:0:0";
        };

        environment.systemPackages = with pkgs; [
            cudatoolkit
            nvidia-container-toolkit
            nvidia-modprobe
            nvitop
            nvidia-docker
            ffmpeg
            lshw
        ];
    };
}
