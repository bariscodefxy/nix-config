#!/usr/bin/env bash
set -euo pipefail

nix flake lock
sudo nix run .#nixosConfigurations.victus.config.system.build.diskoScript
sudo nixos-install --flake .#victus