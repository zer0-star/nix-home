self: super: {
  inherit (super.pkgs.callPackages ../pkgs/nim { })
    nim-unwrapped nimble-unwrapped nim;
}
