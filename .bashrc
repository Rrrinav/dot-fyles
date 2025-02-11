# .bashrc
export USER="admin"

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin::$HOME/.config/rofi/scripts:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
. "$HOME/.cargo/env"

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
# Not supported in the "fish" shell.
(cat ~/.cache/wal/sequences &)
export PATH="${PATH}:${HOME}/.local/bin/"
# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh


export STARSHIP_WAL_COLOR1=$(jq -r '.colors.color1' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR2=$(jq -r '.colors.color2' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR3=$(jq -r '.colors.color3' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR4=$(jq -r '.colors.color4' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR5=$(jq -r '.colors.color5' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR6=$(jq -r '.colors.color6' ~/.cache/wal/colors.json)
export STARSHIP_WAL_COLOR7=$(jq -r '.colors.color7' ~/.cache/wal/colors.json)

eval "$(starship init bash)"

alias ls='lsd'
alias cat='bat'

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# fortune
