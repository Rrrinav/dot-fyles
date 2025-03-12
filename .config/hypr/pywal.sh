#!/bin/bash

# Specify the directory path for wallpapers
DIR="$HOME/.wallpaper"

# Specify the cache directory for wallpapers
CACHE_DIR="$HOME/.cache/wal/schemes"
CACHE_WALLPAPER_DIR="$HOME/.cache/wallpapers"
CACHE_FILE="$CACHE_WALLPAPER_DIR/current_wallpaper.png"

# Ensure the cache directory exists
mkdir -p "$CACHE_DIR"

# Ensure the wal schemes directory exists and clear its contents
WAL_SCHEMES_DIR="$HOME/.cache/wal/schemes"
rm -f "$WAL_SCHEMES_DIR"/*

# Load the environment variables
if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

# Initialize an empty array to store the file names
files=()
cmd=""

# Iterate over all items in the directory
for file in "$DIR"/*; do
  if [ -f "$file" ]; then
    files+=("$file")
    cmd="${cmd}${file}\0icon\x1f${file}\n"
  fi
done

# Prompt the user to select a wallpaper
file=$(echo -en "$cmd" | PREVIEW=true rofi -dmenu -i -p "Select wallpaper:" -show-icons)

# If no file is selected, exit
if [[ -z "$file" ]]; then
  notify-send "Pywal" "No wallpaper selected, exiting." -a 'System'
  exit 1
fi

# Setting color scheme with pywal directly from the selected wallpaper
echo "Setting Color Scheme"
wal -i "$file" -n >/dev/null


# Reload Waybar
waybarpath="$HOME/.config/waybar/style.css"
echo "Reloading Waybar: $waybarpath"
touch "$waybarpath" -m

pkill waybar
waybar &

# Reload Hyprland configuration with colors
echo "Changing Hyprland Colors."
colors=$(cat "$HOME/.cache/wal/colors")
colors=${colors//#/}
readarray -t color <<<"$colors"
hyprTheme="$HOME/.cache/wal/colors-hyprland.conf"
echo '' > "$hyprTheme"

for i in {0..15}; do
  echo "\$color$i = rgb(${color[i]})" >> "$hyprTheme"
done

hyprctl reload

# Change the wallpaper with `swww`
echo "Changing wallpaper with swww"
swww img --transition-type any --transition-fps 165 --transition-pos top-right "$file" >/dev/null

extension="${file##*.}"

# Convert the wallpaper to PNG if necessary
if [[ "$extension" == "jpg" || "$extension" == "jpeg" ]]; then
  echo "Converting JPG to PNG"
  magick "$file" "$CACHE_FILE"
elif [[ "$extension" == "gif" ]]; then
  echo "Extracting representative frame from GIF"
  ffmpeg -i "$file" -vf "select='gte(n\,1)',scale=1920:-1:flags=lanczos" -frames:v 1 "$CACHE_FILE" -y >/dev/null
else
  echo "Copying file directly as PNG"
  magick "$file" "$CACHE_FILE"
fi

notify-send "Wallpaper changed" "New wallpaper and colors applied!" -a 'System'
