# Nix Configuration

This repository contains my personal NixOS and Home Manager configurations, managed using Nix Flakes.

## Table of Contents
- [Structure](#structure)
- [MacOS (Darwin)](#macos-darwin)
  - [Initial Setup](#initial-setup)
  - [Usage](#usage)
- [NixOS](#nixos)
  - [Usage](#usage-1)
- [Customization](#customization)

## Structure

The repository is organized as follows:
- `flake.nix`: The main entry point for the Nix Flake configuration.
- `hosts/`: Contains configuration for specific machines (e.g., `alfred`).
- `system_modules/`: Reusable Nix modules for various system components (e.g., `desktop manager`, `shell`, `window manager`).
- `user_modules/`: Reusable Nix user modules (e.g., `browsers`, `communication tools`, `development tools`).
- `users/`: User-specific configurations
- `create_module.sh`: Script to create new modules.
- `sync-system.sh`, `sync-user.sh`, `sync.sh`: Scripts for synchronizing and deploying configurations.
- `secrets.yaml`: File for storing sensitive information managed by `nix-sops`.

## MacOS (Darwin)

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

### Usage
1. Ensure you have Nix with Flakes enabled installed on your system.
2. Clone this repository:
    ```shell
    git clone https://github.com/Manas73/nix-config.git
    ```
3. Navigate to the repository directory:
    ```shell
    cd nix-config
    ```
4. Apply the configurations:
    ```shell
    ./sync-darwin.sh
    ```

## NixOS

### Usage

To use this configuration:

1. Ensure you have Nix with Flakes enabled installed on your system.
2. Clone this repository:
    ```shell
    git clone https://github.com/Manas73/nix-config.git
    ```
3. Navigate to the repository directory:
    ```shell
    cd nix-config
    ```
4. Apply the configurations using one of the following sync scripts:

   <br>

   - To apply **both system and `home-manager`** configurations:
     ```shell
     ./sync.sh
     ```

   - To apply **only the system** configuration:
     ```shell
     ./sync-system.sh
     ```

   - To apply **only the `home-manager`** configuration:
     ```shell
     ./sync-user.sh
     ```
   <br>

   **Notes:**
   - The sync scripts use `sudo` where necessary, so you may be prompted for your password during execution.
   - The `sync.sh` script combines the functionality of both `sync-system.sh` and `sync-user.sh`, allowing you to update your entire configuration in one go.

   <br>

5. After running any of these scripts, your system will rebuild and apply the new configurations.


## Customization

To customize this configuration for your own use:

1. Modify the `hosts/` directory to match your machine(s).
2. Update user configurations in the `users/` directory.
3. Adjust modules in the `system_modules/` or `user_modules/` directory as needed.
4. Use the `create_module.sh` script to create new modules as required.
5. Utilize the sync scripts (`sync-system.sh`, `sync-user.sh`, `sync.sh`) to deploy your changes.