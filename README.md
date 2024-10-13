# Nix Configuration

This repository contains my personal NixOS and Home Manager configurations, managed using Nix Flakes.

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

## Features

- Modular configuration structure for easy management and reuse.
- Separate host configurations for different machines.
- User-specific Home Manager configurations.
- Configurations for frequently used software and system components.
- Utilizes Nix Flakes for improved reproducibility and dependency management.

## Usage

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