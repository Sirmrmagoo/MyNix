{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}