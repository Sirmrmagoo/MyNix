{ self, inputs, config, ... }:
{
  flake.nixosModules.myMachineConfiguration = { config, pkgs, lib, ... }:
  {
    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.programModules
      self.nixosModules.systemModules
    ];

    users.users."sirmr" = {
      isNormalUser = true;
      description = "sirmr";
      extraGroups = [ "networkmanager" "wheel" ];
    };


    boot.loader.systemd-boot.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
    programs.kdeconnect.enable = true;

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
      gimp
      chatterino7
      qdirstat
      handbrake
      libaacs
      libbluray
      makemkv
      furmark
      mission-center
      openssl
      inputs.dvr-patched.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.areofyl-fetch.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

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

    boot.kernel.sysctl = {
      "vm.max_map_count" = 1048576;
    };

    boot.kernelModules = [ "sg" ];    

    system.stateVersion = "26.05";
  };
}

