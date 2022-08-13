self: super: {
  inherit (super.pkgs.callPackages ../pkgs/nim.nix { })
    nim-unwrapped nimble-unwrapped nim;
}
