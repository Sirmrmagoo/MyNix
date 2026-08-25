{ self, inputs, config, ... }:
{
  flake.nixosModules.ZukoConfiguration = { config, pkgs, lib, ... }:
  {
    imports = [
      self.nixosModules.ZukoHardware
      self.nixosModules.programModules
      self.nixosModules.systemModules
    ];

    users.users."sirmr" = {
      isNormalUser = true;
      description = "sirmr";
      extraGroups = [ "networkmanager" "wheel" "podman" ];
    };

    boot.loader.systemd-boot.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
      protonplus
      modrinth-app-unwrapped
      openjdk21
      pciutils
      bottles
      parsec-bin
      inputs.dvr-patched.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.areofyl-fetch.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    fileSystems."/mnt/NAS" = {
      device = "192.168.68.66:/mnt/JoNAS/Apps";
      fsType = "nfs";
    };

    virtualisation.podman = {
      enable = true;
      dockerCompat = true; # Creates a symlink from docker to podman
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };

    boot.kernelModules = [ "sg" ];    

    system.stateVersion = "26.05";
  };
}

