#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# Starship nur initialisieren, wenn installiert
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Zoxide nur initialisieren, wenn installiert
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi


# Aliases
alias ls='ls --color=auto'
alias bright="sudo ddcutil"
#sudo ddcutil --display 1 setvcp 10 50
# setvcp code percent. 
# code = 10 for Brightness
# code = 12 for Kontrast
# code = 16 for Red value
# code = 18 for Green value
# code = 1A for Blue value
alias grep='grep --color=auto'
alias blue="bluetoothctl"
PS1='[\u@\h \W]\$ '






# Tmux setup script
SCRIPT="$HOME/tmuxProgrammingSetup.sh"  # Pfad zum Skript anpassen
#if [[ -x "$SCRIPT" ]]; then
#    "$SCRIPT"
#fi

# Starte tmux automatisch, wenn es verfügbar ist und wir noch nicht in einer tmux-Session sind
# if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
# sleep 0.1
#  tmux attach-session -t main || tmux new-session -s main 
# fi

# checks if TMUX enviromentvariable is initialised
if [ ! -n "$TMUX" ]; then
 tmux new-session -A -s main bash -i
fi


# In ~/.bashrc
if [[ "$XDG_CURRENT_DESKTOP" == "Hyprland" ]]; then
    alias np="~/.config/wallpaper/script/Random_Wallpaper.sh"
    # hier Hyprland-spezifische Befehle
elif [[ "$XDG_CURRENT_DESKTOP" == "dwm" || "$DESKTOP_SESSION" == "dwm" ]]; then
    CURRENT_HOST=$(hostnamectl --static)
	if [ "$CURRENT_HOST" = "archlinuxtobis-Arch" ]; then

		alias np="feh --bg-scale --randomize ~/dotfiles/Wallpaper/.config/wallpaper/Images/*"
	else

		alias np="feh --bg-scale --randomize ~/Dotfiles/Wallpaper/.config/wallpaper/Images/*"
	fi

    # hier DWM-spezifische Befehle
else
    echo "Unbekannte Session: $XDG_CURRENT_DESKTOP"
fi


# ---- Detect and export display variables ----
if [ -n "$TMUX" ]; then
  # Wenn Wayland läuft, aber Variable fehlt
  if [ -z "$WAYLAND_DISPLAY" ] && [ -d "/run/user/$UID" ]; then

    wayland_socket=$(ls /run/user/$UID | grep -E '^wayland-[0-9]+$' | head -n1)
    if [ -n "$wayland_socket" ]; then
      export WAYLAND_DISPLAY="$wayland_socket"
      export XDG_RUNTIME_DIR="/run/user/$UID"
    fi
  fi

  # Wenn kein Wayland, aber X11 läuft
  if [ -z "$DISPLAY" ] && [ -S /tmp/.X11-unix/X0 ]; then
    export DISPLAY=":0"
    if [ -z "$XAUTHORITY" ] && [ -f "$HOME/.Xauthority" ]; then
      export XAUTHORITY="$HOME/.Xauthority"
    fi
  fi
fi
# ---- End ----
