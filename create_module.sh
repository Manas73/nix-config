#!/usr/bin/env bash

# Check if all arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <system|user> <module_name> <program_name>"
    exit 1
fi

MODULE_TYPE=$1
MODULE_NAME=$2
PROGRAM_NAME=$3

# Define the base directory and settings variable based on the input
if [ "$MODULE_TYPE" = "system" ]; then
    BASE_DIR="system_modules"
    SETTINGS="system_settings"
elif [ "$MODULE_TYPE" = "user" ]; then
    BASE_DIR="user_modules"
    SETTINGS="user_settings"
else
    echo "Error: First argument must be either 'system' or 'user'"
    exit 1
fi

# Create the module directory if it doesn't exist
mkdir -p "$BASE_DIR/$MODULE_NAME"

# Create or update the module's default.nix
MODULE_DEFAULT="$BASE_DIR/$MODULE_NAME/default.nix"
if [ ! -f "$MODULE_DEFAULT" ]; then
    cat << EOF > "$MODULE_DEFAULT"
{ pkgs, lib, ${SETTINGS}, ... }:
let
  functions = import ../functions.nix { inherit pkgs lib; };
  ${MODULE_NAME}_options = [ "$PROGRAM_NAME" ];
in
functions.makeModuleConfig {
  options = ${MODULE_NAME}_options;
  current = ${SETTINGS}.${MODULE_NAME}s;
  module_name = "$MODULE_NAME";
}
EOF
    echo "Created $MODULE_DEFAULT"
else
    sed -i "s/\(${MODULE_NAME}_options = \[.*\)\]/\1\"$PROGRAM_NAME\" ]/" "$MODULE_DEFAULT"
    echo "Updated $MODULE_DEFAULT with $PROGRAM_NAME"
fi

# Create the program's nix file
PROGRAM_DEFAULT="$BASE_DIR/$MODULE_NAME/$PROGRAM_NAME.nix"
cat << EOF > "$PROGRAM_DEFAULT"
{ pkgs, lib, config, ... }: {

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