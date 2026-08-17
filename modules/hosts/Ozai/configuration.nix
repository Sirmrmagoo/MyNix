{ self, inputs, config, ... }:  {

  flake.nixosModules.OzaiConfiguration = { config, pkgs, lib,  ... }:  {

    imports =
      [
        self.nixosModules.OzaiHardware
        self.nixosModules.timeSettings
        self.nixosModules.bootloaderSettings
        self.nixosModules.ozaiNetworking
        self.nixosModules.NvidiaLaptop
      ];

    services.immich = {
      enable = true;
      port = 2283;
      host = "0.0.0.0";
      openFirewall = true;
      mediaLocation = "/mnt/NAS/Immich/immichLibrary";
      accelerationDevices = null;
    };

    systemd.services.immich = {
      environment = {
        LD_LIBRARY_PATH = lib.makeLibraryPath [
            pkgs.cudatoolkit
            pkgs.nvidia-docker
          ];
            CUDA_HOME = "${pkgs.cudatoolkit}";
        };
    };

    services.jellyfin = {
      enable = true;
      openFirewall = true;
      hardwareAcceleration = {
        enable = true;
        type = "nvenc";
        device = "/dev/dri/by-path/pci-0000:01:00.0-render";
      };
    };

    systemd.services.jellyfin.serviceConfig = {
      PrivateDevices = lib.mkForce false;
      DevicePolicy = lib.mkForce "auto";
    };



    services.openssh = {
      enable = true;
      openFirewall = true;
    };

    fileSystems."/mnt/NAS" = {
      device = "192.168.68.66:/mnt/JoNAS/Apps";
      fsType = "nfs";
    };

    environment.systemPackages = with pkgs; [
      lshw
      immich-go
      nvitop
      nvidia-docker
      ffmpeg
      git
    ];

    # Users
    users.users."nixos" = {
      isNormalUser = true;
      description = "nixos";
      extraGroups = [ "networkmanager" "wheel" "video" "render" ];
    };

    users.users."immich" = {
      extraGroups = [ "wheel" "video" "render" ];
    };
    users.groups.immichUser = {};

    users.users.jellyfin = {
      extraGroups = [ "wheel" "video" "render" ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    services.logind.settings.Login.HandleLidSwitch = "ignore";

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "26.05"; # Did you read the comment?

  };
}
