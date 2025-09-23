#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"

eval "$(zoxide init bash)"

# nextPaper
alias np="feh --bg-scale --randomize ~/Dotfiles/Wallpaper/.config/wallpaper/Images/*"
alias ls='ls --color=auto'
alias n='nvim'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

SCRIPT="$HOME/tmuxProgrammingSetup.sh"  # Pfad zum Skript anpassen

#if [[ -x "$SCRIPT" ]]; then
#    "$SCRIPT"
#fi

# Starte tmux automatisch, wenn es verfügbar ist und wir noch nicht in einer tmux-Session sind
# if command -v tmux &> /dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
# sleep 0.1
#  tmux attach-session -t main || tmux new-session -s main 
# fi


if [ ! -n "$TMUX" ]; then
 tmux new-session -A -s main bash -i
fi




