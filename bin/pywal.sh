#!/bin/bash

# Specify the directory path
DIR="$HOME/.wallpaper"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  echo "Directory $DIR does not exist."
  exit 1
fi

# Initialize an empty array to store the file names
files=()
cmd=""

# Iterate over all items in the directory
for file in "$DIR"/*; do
  # Check if the item is a file (not a directory)
  if [ -f "$file" ]; then
    # Add the file name to the array
    files+=("$file")
    cmd=$cmd"$file\0icon\x1f$file\n"
  fi
done

# Prompt the user to select a wallpaper
file=$(echo -en "$cmd" | rofi -dmenu -i -p "Select wallpaper:")

# If no file is selected, exit
if [[ -z $file ]]; then
  notify-send "Pywal" "No wallpaper selected, exiting." -a 'System'
  exit 1
fi

# Extract the file name
filename=$(basename "$file")

echo "${filename}" >"$HOME/.config/theme/bg"

# Setting color scheme with pywal
echo "Setting Color Scheme"
wal -i "$file" -n >/dev/null

# Reloading Waybar
waybarpath="$HOME/.config/waybar/style.css"
echo "Reloading Waybar: $waybarpath"
touch "$waybarpath" -m

# Changing Hyprland colors
echo "Changing Hyprland Colors."
colors=$(cat $HOME/.cache/wal/colors)
colors=${colors//#/}
readarray -t color <<<"$colors"

hyprTheme=$HOME/.cache/wal/colors-hyprland.conf

echo '' >$hyprTheme
for i in {0..15}; do
  echo "\$color$i = rgb(${color[i]})" >>$hyprTheme
done

# Changing the wallpaper with swww
echo "Changing wallpaper with swww"
swww img --transition-type any --transition-fps 165 --transition-pos top-right "$file" >/dev/null

notify-send "Pywal" "Colors updated for Waybar, Hyprland, and wallpaper changed." -a 'System'
