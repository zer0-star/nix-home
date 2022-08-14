self: super: {
  haskell.packages.ghc884 = super.haskell.packages.ghc884.override (orig: { compilerConfig = (self1: super1: (orig.compilerConfig self1 super1) // { haskell-language-server = super.haskell-language-server; }); });
}
