#!/usr/bin/env bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <module_name> <program_name>"
    exit 1
fi

MODULE_NAME=$1
PROGRAM_NAME=$2

# Define the base directory for modules
BASE_DIR="user_modules"

# Create the module directory if it doesn't exist
mkdir -p "$BASE_DIR/$MODULE_NAME"

# Create or update the module's default.nix
MODULE_DEFAULT="$BASE_DIR/$MODULE_NAME/default.nix"
if [ ! -f "$MODULE_DEFAULT" ]; then
    cat << EOF > "$MODULE_DEFAULT"
{ pkgs, lib, user_settings, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  ${MODULE_NAME}_options = [ "$PROGRAM_NAME" ];
in
functions.makeModuleConfig {
  options = ${MODULE_NAME}_options;
  current = user_settings.${MODULE_NAME}s;
  module_name = "$MODULE_NAME";
}
EOF
    echo "Created $MODULE_DEFAULT"
else
    sed -i "s/\(${MODULE_NAME}_options = \[.*\)\]/\1\"$PROGRAM_NAME\" ]/" "$MODULE_DEFAULT"
    echo "Updated $MODULE_DEFAULT with $PROGRAM_NAME"
fi

# Create the program directory
mkdir -p "$BASE_DIR/$MODULE_NAME/$PROGRAM_NAME"

# Create the program's default.nix
PROGRAM_DEFAULT="$BASE_DIR/$MODULE_NAME/$PROGRAM_NAME/default.nix"
cat << EOF > "$PROGRAM_DEFAULT"
{ pkgs, lib, config, user_settings, ... }: {

    options = {
        ${PROGRAM_NAME}.enable = lib.mkEnableOption "enables ${PROGRAM_NAME}";
    };

    config = lib.mkIf config.${PROGRAM_NAME}.enable  {
        home.packages = with pkgs; [ ${PROGRAM_NAME} ];
    };
}
EOF

echo "Created $PROGRAM_DEFAULT"

echo "Module setup complete!"