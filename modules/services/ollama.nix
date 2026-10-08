{ self, inputs, ... }:  {
  flake.nixosModules.Ollama = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;

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

    services.llama-cpp = {
      enable = true;
      package = (pkgs.llama-cpp.override { cudaSupport = true; })

      modelsPreset = {
        # Requires 8GB VRAM 
        "Qwen3.8-27B-GGUF" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          alias = "unsloth/Qwen3.8-27B-GGUF";
          temp = "0.5";
        };

      };
    };
  };
}