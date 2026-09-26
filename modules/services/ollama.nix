{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  

    {

    pkgs.config.allowUnfree = true;

    services.open-webui = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 8282;
    };

    services.ollama = {
      enable = true;
      loadModels = [ "llama3.2:3b" "codegemma:latest" "yi-coder:latest" "llama2:latest" ];
    };
  };
}