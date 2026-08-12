{
  inputs = {

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    dvr-patched = {
      url = "git+https://git.sljusard.com/sljusard/dvr-patched-flake.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    areofyl-fetch.url = "github:areofyl/fetch";

    hyprland.url = "github:hyprwm/Hyprland";

    stylix.url = "github:nix-community/stylix/release-26.05";

  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; }
  (inputs.import-tree ./modules);

}
