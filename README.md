# Nix Configuration

This repository contains my personal NixOS and Home Manager configurations, managed using Nix Flakes.

## Structure

The repository is organized as follows:

- `flake.nix`: The main entry point for the Nix Flake configuration.
- `hosts/`: Contains configuration for specific machines.
- `system_modules/`: Reusable Nix modules for various system components.
- `user_modules/`: Reusable Nix user modules.
- `users/`: User-specific configurations.

## Features

- Modular configuration structure for easy management and reuse.
- Separate host configurations for different machines.
- User-specific Home Manager configurations.
- Configurations for frequently used software.

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
4. Apply the configuration (replace `<host>` with your host name, e.g., 'alfred'):
    ```shell
    sudo nixos-rebuild switch --flake .#<host> --show-trace
    ```

## Customization

To customize this configuration for your own use:

1. Modify the `hosts/` directory to match your machine(s).
2. Update user configurations in the `users/` directory.
3. Adjust modules in the `system_modules/` or `user_modules/` directory as needed.
