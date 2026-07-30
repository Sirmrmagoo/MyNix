{ self, inputs, ... }:
{
  flake.nixosModules.myMachineConfiguration = { config, pkgs, lib, ... }:
  {
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.programModules
    ];

    boot.loader = {
      grub = {
        enable = true;
        device = "nodev"; # "nodev" is used for UEFI
        efiSupport = true;
      };
      efi.canTouchEfiVariables = true;
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    users.users."sirmr" = {
      isNormalUser = true;
      description = "sirmr";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        kdePackages.kate
      ];
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

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

    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    nix.settings.auto-optimise-store = true;

    networking = {
      hostName = "sirmr-nixos";
      networkmanager.enable = true;
    };

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

    services.flatpak.enable = true;

    virtualisation = {
      virtualbox.host.enable = true;
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      kdePackages.qtsvg
      fastfetch
      spotify
      audacity
      blender
      discord
      btop
      vlc
      inochi-creator
      easyeffects
      heroic
      cava
      picard
      librewolf
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    environment.variables = {
      RUSTICL_ENABLE = "radeonsi";
    };

    fileSystems."/mnt/NAS" = {
      device = "192.168.68.66:/mnt/JoNAS/Apps";
      fsType = "nfs";
    };

    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      server.port = 6742;
    };

    boot.kernelModules = [ "sg" ];

    system.stateVersion = "26.05";
  };
}

