pkgs: {
  kiro = pkgs.callPackage ./kiro/package.nix {
    vscode-generic = ./vscode/generic.nix;
  };
}
