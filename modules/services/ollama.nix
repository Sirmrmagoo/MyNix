{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      host = "0.0.0.0";
      port = 8282;
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
    };
  };
}