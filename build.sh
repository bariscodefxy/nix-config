#!/usr/bin/env bash

# NixOS and Home Manager rebuild script with specializations support
# Usage: ./build.sh [options] [target] [specialization]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
TARGET=""
SPECIALIZATION=""
ACTION="switch"  # Default action
DRY_RUN=false
VERBOSE=false
FLAGS=()

# Print usage information
print_help() {
    cat <<EOF
${BLUE}NixOS and Home Manager Rebuild Script${NC}

${YELLOW}Usage:${NC}
  ./build.sh [options] [target] [specialization]

${YELLOW}Targets:${NC}
  system              Build and activate NixOS system configuration
  home                Build and activate Home Manager configuration
  all                 Build and activate both system and home configurations

${YELLOW}Specializations:${NC} (optional, only applies to 'system' or 'all')
  Specify a specialization to build (e.g., "work", "gaming", etc.)

${YELLOW}Options:${NC}
  -h, --help          Show this help message
  -d, --dry-run       Show what would be done without making changes
  -s, --switch        Build and activate the new configuration (default)
  -b, --boot          Build and add to boot loader menu
  -t, --test          Build and activate but don't add to boot loader
  -v, --verbose       Show more detailed output
  --show-trace        Show detailed error information
  --upgrade           Update channels before building
  --clean             Run garbage collection after build

${YELLOW}Examples:${NC}
  ./build.sh system           # Switch to new system configuration
  ./build.sh home             # Switch to new home configuration (no specialization needed)
  ./build.sh all              # Switch both system and home
  ./build.sh system work      # Switch to system with work specialization
  ./build.sh home --dry-run   # Show what home-manager would do
  ./build.sh all --boot --upgrade # Upgrade and add to boot menu

EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            print_help
            exit 0
            ;;
        -d|--dry-run)
            DRY_RUN=true
            FLAGS+=("--show-trace")
            shift
            ;;
        -s|--switch)
            ACTION="switch"
            shift
            ;;
        -b|--boot)
            ACTION="boot"
            shift
            ;;
        -t|--test)
            ACTION="test"
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            FLAGS+=("-v")
            shift
            ;;
        --show-trace)
            FLAGS+=("--show-trace")
            shift
            ;;
        --upgrade)
            UPGRADE=true
            shift
            ;;
        --clean)
            CLEAN=true
            shift
            ;;
        system|home|all)
            TARGET="$1"
            shift
            ;;
        -*)
            echo -e "${RED}Error: Unknown option $1${NC}" >&2
            print_help
            exit 1
            ;;
        *)
            if [[ -z "$SPECIALIZATION" ]]; then
                SPECIALIZATION="$1"
            else
                echo -e "${RED}Error: Too many arguments${NC}" >&2
                print_help
                exit 1
            fi
            shift
            ;;
    esac
done

# Set default target if not specified
if [[ -z "$TARGET" ]]; then
    echo -e "${YELLOW}No target specified, defaulting to 'all'${NC}"
    TARGET="all"
fi

# Function to run a command with dry-run support
run_command() {
    local cmd=("$@")
    
    echo -e "${BLUE}Running:${NC} ${cmd[*]}"
    
    if [ "$DRY_RUN" = true ]; then
        echo -e "${YELLOW}Dry run: Not executing command${NC}"
        return 0
    fi
    
    "${cmd[@]}"
    return $?
}

# Function to handle errors
error_exit() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Update channels if requested
if [ "${UPGRADE:-false}" = true ]; then
    echo -e "${GREEN}Updating Nix channels...${NC}"
    run_command nix-channel --update || error_exit "Failed to update channels"
fi

# Build based on target
case "$TARGET" in
    system)
        echo -e "${GREEN}Building system configuration...${NC}"

        # Construct NixOS flags including specialization
        NIXOS_FLAGS=("${FLAGS[@]}")
        if [[ -n "$SPECIALIZATION" ]]; then
            NIXOS_FLAGS+=("--specialisation" "$SPECIALIZATION")
        fi

        if [ "$ACTION" = "boot" ]; then
            run_command sudo nixos-rebuild boot --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        elif [ "$ACTION" = "test" ]; then
            run_command sudo nixos-rebuild test --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        else
            run_command sudo nixos-rebuild switch --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        fi
        ;;
        
    home)
        echo -e "${GREEN}Building home configuration...${NC}"
        # home-manager is run with only the general FLAGS (no specialization)
        run_command home-manager "$ACTION" --flake .#bariscodefx@victus "${FLAGS[@]}" || error_exit "Home build failed"
        ;;
        
    all)
        echo -e "${GREEN}Building both system and home configurations...${NC}"
        
        # Construct NixOS flags including specialization
        NIXOS_FLAGS=("${FLAGS[@]}")
        if [[ -n "$SPECIALIZATION" ]]; then
            NIXOS_FLAGS+=("--specialisation" "$SPECIALIZATION")
        fi
        
        # Build system first (with specialization)
        if [ "$ACTION" = "boot" ]; then
            run_command sudo nixos-rebuild boot --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        elif [ "$ACTION" = "test" ]; then
            run_command sudo nixos-rebuild test --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        else
            run_command sudo nixos-rebuild switch --flake .#victus "${NIXOS_FLAGS[@]}" || error_exit "System build failed"
        fi
        
        # Then build home (without specialization)
        # We enforce 'switch' for home manager when running 'all' to ensure configuration is applied
        run_command home-manager switch --flake .#bariscodefx@victus "${FLAGS[@]}" || error_exit "Home build failed"
        ;;
        
    *)
        error_exit "Invalid target: $TARGET"
        ;;
esac

# Run garbage collection if requested
if [ "${CLEAN:-false}" = true ]; then
    echo -e "${GREEN}Running garbage collection...${NC}"
    run_command nix-collect-garbage -d || echo -e "${YELLOW}Garbage collection failed, but continuing...${NC}"
fi

echo -e "${GREEN}Build completed successfully!${NC}"