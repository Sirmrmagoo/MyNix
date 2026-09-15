{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      port = 8080;
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}