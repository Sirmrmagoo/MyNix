{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, pkgs-unstable, lib, ... }:  
  
    let
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
    in
    {

    nixpkgs.config.allowUnfree = true;
    pkgs-unstable.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 8282;
      package = pkgs-unstable.open-webui;
    };

    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      loadModels = [ "llama3.2:3b" "codegemma:latest" "yi-coder:latest" "llama2:latest" ];
    };
  };
}