{ pkgs, ... }:

{
  packages = with pkgs; [
    git
    zlib
    hpack
    stack
    haskellPackages.hoogle
    haskellPackages.hasktags
    haskellPackages.haskdogs
    haskell.compiler.ghc945
    haskell.packages.ghc945.haskell-language-server
    haskell.packages.ghc945.hlint
  ];

  enterShell = ''
    Hello fellow hacker
    ghc --version
  '';

}
