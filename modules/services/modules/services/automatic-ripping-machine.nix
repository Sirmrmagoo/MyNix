{ self, inputs, ... }: {
  flake.nixosModules.ARM = { config, pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      lsscsi
    ];

    boot.kernelModules = [ "sg" ];

    users.groups.arm.gid = 1001;

    users.users.arm = {
      isNormalUser = true;
      home = "/home/arm";
      uid = 1001;
      homeMode = "775";
      group = "arm";
      extraGroups = [
        "cdrom"
        "video"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /home/arm/music 0775 arm arm"
      "d /home/arm/Music 0775 arm arm"
      "d /home/arm/logs 0775 arm arm"
      "d /home/arm/media 0775 arm arm"
      "d /home/arm/media/raw 0775 arm arm"
      "d /home/arm/media/transcode 0775 arm arm"
      "d /home/arm/media/transcode/movies 0775 arm arm"
      "d /home/arm/media/transcode/unidentified 0775 arm arm"
      "d /home/arm/media/completed 0775 arm arm"
      "d /home/arm/movies 0775 arm arm"
      "d /home/arm/config 0775 arm arm"
      "d /home/arm/db 0775 arm arm"

    ];

    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "sirmr" ];

    virtualisation.oci-containers = {
      backend = "docker";
      containers = {
        arm = {
          autoStart = true;
          image = "automaticrippingmachine/automatic-ripping-machine:2.22.0";
          volumes = [
            "/home/sirmr/arm:/home/arm"
            "/home/sirmr/arm/music:/home/arm/music"
            "/home/sirmr/arm/logs:/home/arm/logs"
            "/home/sirmr/arm/media:/home/arm/media"
            "/home/sirmr/arm/config:/etc/arm/config"
          ];
          ports = [ "8080:8080" ];
          environment = {
            ARM_UID = "1001";
            ARM_GID = "1001";
          };
          extraOptions = [
            "--privileged"
            "--device=/dev/sr0:/dev/sr0"
          ];
        };
      };
    };
  };
}
