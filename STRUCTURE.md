# Repository Structure

This document describes the modular organization of the nix-config repository.

## Directory Layout

```
.
├── flake.nix                    # Main flake configuration
├── home-manager/                # Home Manager configurations
│   ├── home.nix                # Main home configuration (imports only)
│   ├── user.nix                # User-specific settings
│   ├── overlays.nix            # Nixpkgs overlays configuration
│   ├── system.nix              # XDG and activation scripts
│   ├── programs/               # Program configurations
│   │   ├── apps/              # Application packages
│   │   │   ├── browsers/      # Web browsers (zen-browser, tor)
│   │   │   ├── audio.nix      # Audio applications
│   │   │   ├── communication.nix  # Chat & email clients
│   │   │   ├── media.nix      # Media tools (obs, vlc, gimp)
│   │   │   ├── network.nix    # Network tools (filezilla, vnc)
│   │   │   ├── productivity.nix   # Office & file management
│   │   │   ├── terminal.nix   # Terminal emulator (alacritty)
│   │   │   ├── nixcord.nix    # Discord configuration
│   │   │   └── spotify.nix    # Spotify configuration
│   │   ├── compatibility/     # Compatibility layers (xwayland)
│   │   ├── desktop/           # Desktop environment (niri, stylix, dms)
│   │   ├── gaming/            # Gaming packages
│   │   ├── programming/       # Development tools & IDEs
│   │   └── terminal/          # CLI tools & shell configuration
│   └── services/              # User services
├── nixos/                      # NixOS system configurations
│   ├── configuration.nix       # Main NixOS configuration
│   ├── hardware-configuration.nix  # Hardware-specific settings
│   ├── modules/               # System modules
│   │   ├── bluetooth.nix      # Bluetooth configuration
│   │   ├── boot.nix           # Boot loader settings
│   │   ├── fonts.nix          # Font configuration
│   │   ├── garbage.nix        # Garbage collection
│   │   ├── graphics.nix       # Graphics/GPU configuration
│   │   ├── network.nix        # Network configuration
│   │   ├── nixpkgs-config.nix # Nixpkgs settings
│   │   ├── program-config.nix # System program enables
│   │   ├── system-packages.nix # System package list
│   │   ├── system.nix         # System settings
│   │   ├── user.nix           # User account configuration
│   │   ├── virtualisation.nix # Virtualization settings
│   │   └── xdg.nix            # XDG portal configuration
│   └── services/              # System services
│       ├── network/           # Network services
│       │   ├── nginx.nix      # Web server
│       │   ├── httpd.nix      # Apache server
│       │   ├── openssh.nix    # SSH server
│       │   ├── dnscrypt.nix   # DNS encryption
│       │   ├── squid.nix      # Proxy server
│       │   ├── mullvad.nix    # VPN
│       │   ├── singbox.nix    # Network tool
│       │   ├── zapret.nix     # DPI bypass
│       │   └── create_ap.nix  # WiFi hotspot
│       ├── desktop/           # Desktop services
│       │   ├── pipewire.nix   # Audio server
│       │   ├── xscreensaver.nix # Screen saver
│       │   ├── greetd.nix     # Display manager
│       │   └── flatpak.nix    # Flatpak support
│       ├── power/             # Power management
│       │   ├── tlp.nix        # Laptop power management
│       │   └── upower.nix     # Power monitoring
│       ├── database/          # Database services
│       │   └── mariadb.nix    # MariaDB server
│       └── hardware/          # Hardware-specific services
│           └── victus-control/ # HP Victus laptop control
├── modules/                    # Reusable modules
│   ├── nixos/                 # NixOS modules (for sharing)
│   └── home-manager/          # Home Manager modules (for sharing)
├── overlays/                   # Package overlays
├── pkgs/                       # Custom packages
│   ├── gnome-ext-hanabi/      # GNOME extension
│   ├── hp-wmi-fan-and-backlight-control/  # Hardware control
│   ├── phpmyadmin/            # Database admin tool
│   └── victus-control/        # Laptop control utility
└── STRUCTURE.md               # This file
```

## Modular Design Principles

### 1. Separation of Concerns
- **Configuration** is split into logical modules (user, overlays, system)
- **Programs** are categorized by purpose (apps, terminal, gaming, etc.)
- **Services** are organized by domain (network, desktop, power, etc.)

### 2. Semantic Naming
- File names clearly indicate their purpose
- Directory structure follows logical groupings
- No generic names like `pkgs.nix` or `default.nix` at top levels

### 3. Modularity
- Each file has a single, clear responsibility
- Files can be easily enabled/disabled by commenting imports
- Related configurations are grouped in subdirectories

### 4. Maintainability
- Easy to locate specific configurations
- Changes to one area don't affect unrelated areas
- New configurations can be added without modifying existing files

## Usage Examples

### Adding a New Application
To add a new media application:
1. Add the package to `home-manager/programs/apps/media.nix`
2. If it needs configuration, create a new file in the appropriate category
3. Import it in `home-manager/programs/apps/default.nix`

### Adding a New Service
To add a new network service:
1. Create `nixos/services/network/myservice.nix`
2. Import it in `nixos/services/network/default.nix`

### Disabling a Module
To disable a module, simply comment out its import in the parent `default.nix`

## Migration from Previous Structure

| Old Location | New Location | Reason |
|-------------|-------------|--------|
| `home-manager/home.nix` (all-in-one) | Split into `user.nix`, `overlays.nix`, `system.nix` | Separation of concerns |
| `home-manager/programs/apps/pkgs.nix` | Split into category files (media, communication, etc.) | Semantic organization |
| `nixos/modules/programs.nix` | Split into `program-config.nix` and `system-packages.nix` | Separate enables from packages |
| `nixos/services/*.nix` (flat) | Organized into `network/`, `desktop/`, `power/`, etc. | Logical grouping |
| `pkgs/phpmyadmin/pkg.nix` | `pkgs/phpmyadmin/package.nix` | Standard Nix convention |

