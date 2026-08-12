{ self, inputs, ... }: {

    flake.nixosModules.programing = { config, lib, pkgs, ... }:
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

