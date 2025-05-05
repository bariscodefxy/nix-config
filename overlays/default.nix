{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: { };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  wayland-overlay = final: _prev: import inputs.nixpkgs-wayland;
}
