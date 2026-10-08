{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  

    {

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [
      (pkgs.llama-cpp.override { cudaSupport = true; })
    ];

    services.open-webui = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 8282;
    };
    services.llama-cpp.port = 8585;

    services.ollama = {
      enable = true;
      loadModels = [ "llama3.2:3b" "codegemma:latest" "yi-coder:latest" "llama2:latest" ];
    };
  };
}