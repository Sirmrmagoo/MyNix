{ self, inputs, ... }: {

    flake.nixosModules.bootloaderSettings = { config, pkgs, lib, ... }: {
        boot.loader.systemd-boot.enable = true;
    };
}
