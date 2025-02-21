#!/bin/bash

# Path to your starship.toml file
STARSHIP_TOML="$HOME/.config/starship.toml"

# Get the color from Pywal
COLOR=$(jq -r '.colors.color4' ~/.cache/wal/colors.json)

# Check if the color was retrieved
if [[ -z "$COLOR" ]]; then
  echo "Error: Could not retrieve color from ~/.cache/wal/colors.json"
  exit 1
fi

# Replace placeholder in starship.toml with the actual color
sed -i "s/{{env:STARSHIP_WAL_COLOR4}}/$COLOR/g" "$STARSHIP_TOML"

echo "Successfully updated $STARSHIP_TOML with color $COLOR"

