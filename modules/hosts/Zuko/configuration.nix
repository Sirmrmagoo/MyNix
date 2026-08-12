{ self, inputs, config, ... }:  {

  flake.nixosModules.ZukoConfiguration = { config, pkgs, lib,  ... }:  {

    imports =
      [
        ./hardware-configuration.nix
      ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    networking.networkmanager.enable = false;
    networking.useDHCP = false;
    networking.interfaces.eno2 = {
      ipv4.addresses = [{
        address = "192.168.68.72";
        prefixLength = 22;
      }];
    };
    networking.defaultGateway = "192.168.68.1";
    networking.nameservers = ["1.1.1.1" "8.8.8.8"];

    services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/mnt/NAS/Immich/immichLibrary";
    accelerationDevices = null;
    };

    services.immich.machine-learning = {
      enable = true;
      environment = {
        HF_XET_CACHE = "/var/cache/immich/huggingface-xet";
        ONNXRUNTIME_PROVIDERS = "CUDAExecutionProvider,CPUExecutionProvider";
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

    services.openssh = {
    enable = true;
    openFirewall = true;
    };


    fileSystems."/mnt/NAS" = {
      device = "192.168.68.66:/mnt/JoNAS/Apps";
      fsType = "nfs";
    };

    nix.settings = {
      substituters = [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = false;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia-container-toolkit.enable = true;

    hardware.nvidia.prime = {
      sync.enable = true;
      intelBusId = "PCI:0@0:2:0";
      nvidiaBusId = "PCI:1@0:0:0";
    };

    systemd.services.jellyfin.serviceConfig = { DeviceAllow = [
        "/dev/dri/renderD128 rw"
        "/dev/nvidia0 rw"
        "/dev/nvidiactl rw"
        "/dev/nvidia-uvm rw"
        "/dev/nvidia-modeset rw"
      ];
    };

    systemd.services.immich-machine-learning.serviceConfig = {
      DeviceAllow = [
        "/dev/nvidia0 rw"
        "/dev/nvidiactl rw"
        "/dev/nvidia-uvm rw"
        "/dev/nvidia-modeset rw"
      ];
    };

    environment.systemPackages = with pkgs; [
      lshw
      immich-go
      nvitop

    ];

    services.logind.settings.Login.HandleLidSwitch = "ignore";

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos"; # Define your hostname.

    time.timeZone = "America/Los_Angeles";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."nixos" = {
      isNormalUser = true;
      description = "nixos";
      extraGroups = [ "networkmanager" "wheel" "video" "render" ];
    };

    users.users."immich" = {
      description = "immich";
      extraGroups = [ "wheel" "video" "render" ];
    };
    users.groups.immichUser = {};

    users.users.jellyfin = {
      extraGroups = [ "wheel" "video" "render" ];
    };


    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "26.05"; # Did you read the comment?

  };
}
