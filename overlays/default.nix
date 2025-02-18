{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: { };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  wayland-overlay = final: _prev: import inputs.nixpkgs-wayland;
}
