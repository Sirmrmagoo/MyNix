{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      package = pkgs-unstable.open-webui;
      port = "8181";
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}