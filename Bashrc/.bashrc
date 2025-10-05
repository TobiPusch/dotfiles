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
alias np="feh --bg-scale --randomize ~/Dotfiles/Wallpaper/.config/wallpaper/Images/*"
alias ls='ls --color=auto'
alias n='nvim'
alias grep='grep --color=auto'
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




