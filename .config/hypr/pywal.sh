#!/bin/bash

# Specify the directory path for wallpapers
DIR="$HOME/.wallpaper"

# Specify the cache directory and file
CACHE_DIR="$HOME/.cache/wallpapers"
CACHE_FILE="$CACHE_DIR/current_wallpaper.png"

# Ensure the cache directory exists
mkdir -p "$CACHE_DIR"

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
    cmd=$cmd"$file\0icon\x1f$file\n"
  fi
done

# Prompt the user to select a wallpaper
file=$(echo -en "$cmd" | PREVIEW=true rofi -dmenu -i -p "Select wallpaper:" -show-icons)

# If no file is selected, exit
if [[ -z $file ]]; then
  notify-send "Pywal" "No wallpaper selected, exiting." -a 'System'
  exit 1
fi

# Extract the file extension and filename
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
  magick "$file" "$CACHE_FILE"   # Change here: magick convert → magick
fi

# Setting color scheme with pywal
echo "Setting Color Scheme"
wal -i "$CACHE_FILE" -n >/dev/null

# Reload other components, like Waybar or Hyprland (if needed)
waybarpath="$HOME/.config/waybar/style.css"
echo "Reloading Waybar: $waybarpath"
touch "$waybarpath" -m

pkill waybar
waybar &

# Reload Hyprland configuration with colors
echo "Changing Hyprland Colors."
colors=$(cat $HOME/.cache/wal/colors)
colors=${colors//#/}
readarray -t color <<<"$colors"
hyprTheme=$HOME/.cache/wal/colors-hyprland.conf
echo '' >$hyprTheme
for i in {0..15}; do
  echo "\$color$i = rgb(${color[i]})" >>$hyprTheme
done

hyprctl reload
# Change the wallpaper with `swww`
echo "Changing wallpaper with swww"
swww img --transition-type any --transition-fps 165 --transition-pos top-right "$file" >/dev/null

notify-send "Wallpaper changed" "New wallpaper and colors applied!" -a 'System'


