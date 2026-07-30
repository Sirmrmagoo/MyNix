{ self, inputs, ... }: {

    flake.nixosConfigurations.programing = { config, lib, pkgs, ... }:

{

    environment.systemPackages = with pkgs; [
        jetbrains.pycharm
        jetbrains.rider
        devenv
        vscode
        github-desktop
        git
    ];

};


}

