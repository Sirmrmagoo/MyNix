{ self, inputs, ... }:  {
  flake.nixosModules.AI = { config, pkgs, lib, ... }:  {

    nixpkgs.config.allowUnfree = true;
    
    services.llama-cpp = {
      enable = true;
      port = 8585;
      host = "0.0.0.0";
      package = pkgs.llama-cpp-vulkan;

      modelsPreset = {
        # Requires 8GB VRAM 
        "Qwen3.8-27B-GGUF" = {
          hf-repo = "unsloth/Qwen3.8-27B-GGUF";
          alias = "unsloth/Qwen3.8-27B-GGUF";
          temp = "0.5";
        };

        "Balls" = {
          hf-repo = "unsloth/LFM2.5-8B-A1B-GGUF";
          hf-file = "LFM2.5-8B-A1B-UD-Q4_K_XL.gguf";
          alias = "unsloth/LFM2.5-8B-A1B-GGUF";
          temp = "0.2";
          repeat-penalty = "1.05";
          top-k = "80";
        };

      };
    };
  };
}