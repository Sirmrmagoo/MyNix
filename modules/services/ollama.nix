{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, pkgs-unstable, lib, ... }:  
    let
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
    in{

    services.open-webui = {
      enable = true;
      package = pkgs-unstable.open-webui;
      port = "114";
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;

    };
  };
}