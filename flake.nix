{
  description = "Home Manager configuration of zer0-star";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidal.url = "github:mitchmindtree/tidalcycles.nix";
    nur.url = github:nix-community/NUR;
    # codex.url = github:herp-inc/codex;
  };

  outputs = { nixpkgs, home-manager, tidal, nur, ... }@inputs:
    let
      system = builtins.currentSystem;
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        nur.overlay
        tidal.overlays.default
      ];
    in {
      homeConfigurations.zer0-star = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          # codex.hmModule.${system}
          # ({ ... }: {
          #   codex.enable = true;
          # })
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs overlays;
        };
      };
    };
}
