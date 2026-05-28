<div align="center">
  <h1> nix-config</h1>
  <p><strong>Declarative NixOS + home-manager flake for HP Victus · Hyprland · Caelestia</strong></p>

  <p>
    <img src="https://img.shields.io/badge/NixOS-unstable-blue?style=flat-square&logo=nixos&logoColor=white" alt="NixOS">
    <img src="https://img.shields.io/badge/Hyprland-Wayland-ff69b4?style=flat-square" alt="Hyprland">
    <img src="https://img.shields.io/badge/Caelestia-Shell-8b5cf6?style=flat-square" alt="Caelestia">
    <img src="https://img.shields.io/badge/License-GPLv3-green?style=flat-square" alt="License">
    <img src="https://img.shields.io/badge/HP-Victus-orange?style=flat-square" alt="HP Victus">
  </p>
</div>

---

##  Gallery

> Screenshots coming soon.

| Desktop | Launcher | Spotify |
|---------|----------|---------|
| ![][screenshot-desktop] | ![][screenshot-launcher] | ![][screenshot-spotify] |

<!--
TODO: Add real screenshots
Replace these with actual image URLs
[screenshot-desktop]: https://
[screenshot-launcher]: https://
[screenshot-spotify]: https://
-->

---

##  Features

###  System

- **NixOS** on `nixos-unstable` with **home-manager**
- **Dual nixpkgs** — `nixos-unstable` for freshness + `nixos-25.11` pinned for stability
- **NixOS specialisations** — boot-time profiles for `sing-box` (VPN) and `zapret` (DPI bypass)
- **Automatic GC** — daily garbage collection, deletes after 3 days
- **Zram swap** — compressed in-memory swap for performance

###  Desktop

- **Hyprland** — Wayland compositor with gradient borders, blur, and smooth animations
- **Caelestia Shell** — Quickshell-based panel, launcher, and notification daemon (systemd-integrated)
- **greetd** — minimal display manager, launches Hyprland directly
- **XDG Portal** configured for Hyprland screen cast, screenshot, and remote desktop
- **Apple cursors**, GTK theming with Noto Sans + Adwaita icons

###  Development

| Tool | Purpose |
|------|---------|
| **VSCodium** | Extensions: Nix, Zig, PHP, Svelte, Roo-Cline AI |
| **Zed** | Lightweight editor |
| **Windsurf** | AI-native IDE |
| **Neovim** | Terminal editor with LSP and completion |
| **opencode** | CLI AI coding assistant |
| **claude-code** | Anthropic's CLI agent |
| **PHP 8.4 + Composer** | Web dev |
| **Node.js 24** | JavaScript runtime |
| **nixd + nixfmt** | Nix language tooling |
| **direnv + git** | Dev environment automation |

###  Web Stack

- **nginx** + **php-fpm** hosting **phpMyAdmin**
- **MariaDB** database server
- Full LAMP stack declaratively configured

###  Gaming

- **Steam** with `programs.steam`
- **PrismLauncher** — Minecraft (cracked variant)
- **Bottles** — Windows emulation
- **OBS Studio** + vkcapture for game recording
- **lunar-client**, **SuperTuxKart**, **Half-Life SDK**

###  Media & Communication

- **Vesktop** (Discord) with **nixcord** — declarative Discord modding
- **Spicetify** — themed Spotify with adblock, hide podcasts, shuffle+
- **Element**, **Cinny** — Matrix clients
- **Thunderbird** — email
- **mpv**, **VLC** — video players
- **GIMP**, **Audacity** — creative tools

###  Network & Security

- **sing-box** — TUN-based VPN client with auto gateway detection (NixOS specialisation)
- **zapret** — DPI bypass tool (NixOS specialisation)
- **dnscrypt-proxy** — encrypted DNS
- **Mullvad VPN** — privacy VPN
- **OpenSSH** — key-based SSH server
- **Firewall** — strict with selective port opening

###  Hardware Support (HP Victus)

```nix
# Custom fan & backlight control kernel module
services.victus-control.enable = true;
```

- **victus-control** — custom kernel module for fan speed and keyboard backlight
- **NVIDIA RTX + Intel UHD** — PRIME sync, proprietary driver
- **v4l2loopback** — virtual video devices
- **ddcutil** — external monitor control
- **lm_sensors** — hardware monitoring

---

##  Structure

```
nix-config/
├── flake.nix                   # Flake entry, inputs, outputs
├── flake.lock                  # Pinned dependencies
│
├── nixos/
│   ├── configuration.nix       # System entry point
│   ├── hardware-configuration.nix
│   ├── modules/
│   │   ├── desktop.nix         # Hyprland, env vars, system packages
│   │   ├── graphics.nix        # NVIDIA + Intel PRIME
│   │   ├── network.nix         # NetworkManager, firewall
│   │   ├── boot.nix            # Kernel params, bootloader
│   │   ├── system.nix          # Locale, timezone, keyboard
│   │   ├── fonts.nix           # Fonts & fontconfig
│   │   ├── user.nix            # User & groups
│   │   ├── nixpkgs-config.nix  # Nix settings, overlays, unfree
│   │   ├── xdg.nix             # XDG desktop portal
│   │   ├── system-packages.nix # System-wide packages
│   │   ├── virtualisation.nix  # Docker, VirtualBox
│   │   ├── bluetooth.nix
│   │   ├── garbage.nix         # Auto GC
│   │   └── program-config.nix  # ZSH, dconf, nix-ld
│   └── services/
│       ├── desktop/
│       │   ├── greetd.nix      # Display manager
│       │   ├── pipewire.nix    # Audio
│       │   └── flatpak.nix
│       ├── hardware/
│       │   └── victus-control/ # Kernel module service
│       ├── network/
│       │   ├── singbox.nix     # VPN (specialisation)
│       │   ├── zapret.nix      # DPI bypass (specialisation)
│       │   ├── dnscrypt.nix
│       │   ├── openssh.nix
│       │   ├── mullvad.nix
│       │   ├── nginx.nix       # LAMP stack
│       │   └── squid.nix
│       └── database/
│           └── mariadb.nix
│
├── home-manager/
│   ├── home.nix
│   ├── user.nix
│   ├── system.nix              # XDG desktop files
│   ├── overlays.nix
│   ├── programs/
│   │   ├── desktop/
│   │   │   ├── hyprland.nix    # Hyprland config
│   │   │   ├── caelestia.nix   # Caelestia shell
│   │   │   ├── gtk.nix
│   │   │   └── cursor.nix
│   │   ├── apps/               # All user applications
│   │   ├── gaming/
│   │   ├── programming/
│   │   └── terminal/
│   └── services/
│
├── pkgs/                       # Custom packages
│   ├── victus-control/         # HP Victus fan/backlight
│   ├── hlsdk/                  # Half-Life SDK
│   └── phpmyadmin/             # phpMyAdmin package
│
├── overlays/                   # Package overlays
└── modules/                    # Reusable NixOS/home-manager modules
```

---

##  Key Bindings

| Keys | Action |
|------|--------|
| `SUPER + SPACE` | App launcher (Caelestia) |
| `SUPER + Q` | Terminal (Alacritty) |
| `SUPER + B` | Browser (Helium) |
| `SUPER + E` | File manager (Thunar) |
| `SUPER + C` | Close window |
| `SUPER + M` | Exit Hyprland |
| `SUPER + F` | Fullscreen |
| `SUPER + V` | Toggle floating |
| `SUPER + [0-9]` | Switch workspace |
| `SUPER + SHIFT + [0-9]` | Move window to workspace |
| `SUPER + arrow` | Focus direction |
| `SUPER + P` | Pseudo-tile |
| `SUPER + J` | Toggle split |
| `Print` | Region screenshot → swappy |
| `SHIFT + Print` | Full screenshot → swappy |
| `SUPER + Print` | Region screenshot → clipboard |
| `XF86MonBrightnessDown/Up` | Brightness ±5% |
| `XF86AudioLower/RaiseVolume` | Volume ±5% |
| `XF86AudioMute` | Mute toggle |
| `XF86AudioMicMute` | Mic mute toggle |

---

##  Quick Start

```bash
# Clone
git clone https://github.com/bariscodefx/nix-config
cd nix-config

# Build & switch system
sudo nixos-rebuild switch --flake .#victus

# Build & switch home-manager
home-manager switch --flake .#bariscodefx@victus
```

> **Note**: Hardware-specific entries like `hardware-configuration.nix` may need adjustment for non-Victus laptops.

---

##  Specialisations

Boot into specialized profiles at GRUB:

- **sing-box** — TUN-based VPN with auto gateway detection
- **zapret** — DPI bypass with dnscrypt-proxy

```bash
# Rebuild with specialisation
sudo nixos-rebuild switch --flake .#victus

# Then select at boot or:
sudo nix-env --set-config specialisation singbox
```

---

##  Custom Packages

| Package | Description |
|---------|-------------|
| `victus-control` | HP Victus fan speed & keyboard backlight control |
| `hlsdk` | Half-Life SDK game data |
| `phpmyadmin` | phpMyAdmin with pre-configured MySQL auth |

---

##  Flake Inputs

| Input | Source | Purpose |
|-------|--------|---------|
| `nixpkgs` | `nixos-unstable` | Main package set |
| `nixpkgs-stable` | `nixos-25.11` | Stable fallback |
| `home-manager` | `nix-community/home-manager` | User config |
| `spicetify-nix` | `Gerg-L/spicetify-nix` | Spotify theming |
| `helium` | `schembriaiden/helium-browser-nix-flake` | Browser |
| `nix-vscode-extensions` | `nix-community/nix-vscode-extensions` | VSCodium extensions |
| `prismlauncher` | `Diegiwg/PrismLauncher-Cracked` | Minecraft launcher |
| `caelestia-shell` | `caelestia-dots/shell` | Desktop shell |
| `nixcord` | `FlameFlag/nixcord` | Discord modding |

---

##  License

This project is licensed under the **GNU General Public License v3.0** — see [LICENSE](./LICENSE).

---

##  Credits

- [NixOS](https://nixos.org/) & [home-manager](https://github.com/nix-community/home-manager)
- [Hyprland](https://hyprland.org/) — the compositor
- [Caelestia Shell](https://github.com/caelestia-dots/shell) — desktop shell
- [nixcord](https://github.com/FlameFlag/nixcord) — Discord modding
- [spicetify-nix](https://github.com/Gerg-L/spicetify-nix) — Spotify theming
