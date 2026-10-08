{ self, inputs, config, ... }:
{
  flake.nixosModules.ZukoConfiguration = { config, pkgs, lib, ... }:
  {
    imports = [
      self.nixosModules.ZukoHardware
      self.nixosModules.programModules
      self.nixosModules.systemModules
      self.nixosModules.ARM
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
      spotify
      audacity
      blender
      discord
      btop
      inochi-creator
      easyeffects
      heroic
      cava
      picard
      librewolf
      gimp
      chatterino7
      qdirstat
      libaacs
      libbluray
      makemkv
      furmark
      mission-center
      openssl
      protonplus
      modrinth-app
      openjdk21
      pciutils
      bottles
      parsec-bin
      kitty
      p7zip
      vlc
      pwvucontrol
      wayvr
      wget
      input-remapper
      antimicrox
      melonloader-installer
      bs-manager
      protontricks
      usb-modeswitch
      sc-controller
      oversteer
      unzip
      rubyPackages.glib2
      rar
      godot
      inputs.dvr-patched.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.areofyl-fetch.packages.${pkgs.stdenv.hostPlatform.system}.default
      kdePackages.wacomtablet
      config.boot.kernelPackages.digimend
      linuxKernel.packages.linux_7_1.new-lg4ff
    ];

    services.hardware.openrgb.enable = true;

    hardware.opentabletdriver.enable = true;
    services.xserver.digimend.enable = true;
    hardware.uinput.enable = true;

    hardware.new-lg4ff.enable = true;

    fileSystems."/mnt/NAS" = {
      device = "192.168.68.66:/mnt/JoNAS/Apps";
      fsType = "nfs";
    };

    services.monado = {
      enable = true;
      highPriority = true;
      defaultRuntime = true; # Register as default OpenXR runtime
    };

    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };


      
    programs.bash = {
	    enable = true;
	    shellAliases = {
        fetch3d = "fetch --infinite";
   		  switch = "sudo nixos-rebuild switch";
      };
    };

    boot.kernelModules = [ "sg" "uinput" ];    

    system.stateVersion = "26.05";
  };
}

