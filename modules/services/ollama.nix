{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    services.open-webui.enable = true;

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;

    };
  };
}
