{
  description = "Home Manager configuration of zer0-star";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/88195a94f390381c6afcdaa933c2f6ff93959cb4";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidal.url = "github:mitchmindtree/tidalcycles.nix";
    nur.url = "github:nix-community/NUR";
    # codex.url = github:herp-inc/codex;
    xremap.url = "github:xremap/nix-flake";
    # xremap.inputs.nixpkgs.follows = "nixpkgs";
    pwndbg.url = "github:pwndbg/pwndbg";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # moonlight = {
    #   url = "github:moonlight-mod/moonlight";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      tidal,
      nur,
      xremap,
      pwndbg,
      treefmt-nix,
      nix-index-database,
      nix-vscode-extensions,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [
        nur.overlays.default
        tidal.overlays.default
        (final: prev: {
          pwndbg = pwndbg.packages.${system}.pwndbg;
        })
        nix-vscode-extensions.overlays.default
      ];
      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      homeConfigurations.zer0-star = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          xremap.homeManagerModules.default
          nix-index-database.hmModules.nix-index
        ];

        extraSpecialArgs = {
          inherit inputs overlays;
        };
      };

      formatter.${system} = treefmtEval.config.build.wrapper;
      checks.${system}.formatting = treefmtEval.config.build.check self;
    };

  nixConfig = {
    extra-substituters = [
      "https://pwndbg.cachix.org"
    ];
    extra-trusted-public-keys = [
      "pwndbg.cachix.org-1:HhtIpP7j73SnuzLgobqqa8LVTng5Qi36sQtNt79cD3k="
    ];
  };
}
