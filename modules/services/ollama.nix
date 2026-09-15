{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      port = 127.0.0.1:8181;
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}