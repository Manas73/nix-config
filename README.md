# Nix Configuration

My personal NixOS and macOS (nix-darwin) configurations, using flakes for comprehensive, modular, and reproducible system management.

## Repository Structure

```
.
├── flake.nix         # Main entry point defining system configurations
├── mk-functions.nix  # Helper functions for building configurations
├── hosts/            # Host-specific configurations
│   ├── nixos/        # NixOS host configurations
│   │   ├── modules/  # NixOS system modules (formerly system_modules)
│   └── darwin/       # Darwin (macOS) host configurations
├── users/            # User configurations and home-manager settings
├── modules/          # Shared home-manager modules
├── overlays/         # Custom package definitions and modifications
├── scripts/          # Utility scripts for working with the configuration
└── secrets.yaml      # Encrypted secrets using sops-nix
```

## Key Features

- Multi-system support (NixOS and macOS)
- Modular configuration for easy reuse and sharing
- User-specific home-manager configurations
- Encrypted secrets with sops-nix
- Separate stable and unstable package channels
- Organized overlays for custom packages and modifications

## macOS (Darwin)

### Initial Setup

1. Install Homebrew Package Manager. More information can be found [here](https://brew.sh).
    ```shell
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. Install the Nix Package Manager on your system. More information can be found [here](https://nixos.org/manual/nix/stable/installation/installing-binary.html).
    ```shell
    sh <(curl -L https://nixos.org/nix/install)~
    ```
3. Create a nix config directory
    ```shell
    mkdir -p ~/.config/nix
    ```
4. Allow experimental features to use flakes
    ```shell
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
    ```
5. Install Nix-Darwin:
    ```shell
    nix run nix-darwin -- switch --flake .#<host>
    ```

6. Restart your shell.

## Usage

### Applying System Configuration

Using helper scripts (automatically detects system type):
```bash
./scripts/sync.sh             # Apply both system and user config
./scripts/sync-system.sh      # Apply only system config
./scripts/sync-user.sh        # Apply only user config
```

Manual commands:
```bash
# For NixOS
sudo nixos-rebuild switch --flake .#hostname

# For macOS
darwin-rebuild switch --flake .#hostname
```

### Applying User Configuration

Using helper script:
```bash
./scripts/sync-user.sh
```

Manual command:
```bash
home-manager switch --flake .#username
```

### Development Environment

Enter a development shell with useful tools:
```bash
nix-shell
```

Format Nix files:
```bash
./scripts/format.sh
```

### Updating Flake Inputs

```bash
nix flake update
```

## Adding a New Host

1. Create a directory in the appropriate location:
   - For NixOS: `hosts/nixos/hostname`
   - For Darwin: `hosts/darwin/hostname`
2. Add host-specific configuration
3. Add the host to `flake.nix` in the appropriate outputs section

## Adding a New User

1. Create a directory in `users/` with the username
2. Create `configuration.nix` and `home.nix` files
3. Add the user to a host configuration in `flake.nix`

## Adding Custom Packages

Custom packages can be added in the `overlays/` directory:
- `overlays/additions/` - New packages not in nixpkgs
- `overlays/modifications/` - Modifications to existing packages
- `overlays/versions/` - Pinned package versions
