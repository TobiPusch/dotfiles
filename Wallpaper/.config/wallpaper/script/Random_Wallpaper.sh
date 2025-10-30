#!/bin/bash

# --- Einstellungen ---
WALLPAPER_DIR="$HOME/.config/wallpaper/Images"
STATE_FILE="$HOME/.config/wallpaper/.last_image_index"

# Aktuelles Wallpaper herausfinden
CURRENT_WALL=$(hyprctl hyprpaper listloaded | awk '{print $2}' | head -n 1)
CURRENT_BASENAME=$(basename "$CURRENT_WALL" 2>/dev/null)

# --- Alle Bilder sammeln ---
readarray -t ALL_IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

# --- Auswahl-Logik ---
if [ -n "$1" ]; then
    # Automatisch bestes fuzzy match auswählen (ohne Menü)
    SELECTED=$(printf "%s\n" "${ALL_IMAGES[@]}" | fzf --filter="$1" | head -n 1)
else
    # Keine Eingabe → zufälliges anderes Wallpaper
    readarray -t MATCHES < <(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_BASENAME" \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))
    NUM_MATCHES=${#MATCHES[@]}

    if [ "$NUM_MATCHES" -eq 0 ]; then
        echo "❌ Kein Wallpaper gefunden."
        exit 1
    fi

    if [ -f "$STATE_FILE" ]; then
        LAST_INDEX=$(cat "$STATE_FILE")
    else
        LAST_INDEX=-1
    fi

    NEXT_INDEX=$(( (LAST_INDEX + 1) % NUM_MATCHES ))
    echo "$NEXT_INDEX" > "$STATE_FILE"
    SELECTED="${MATCHES[$NEXT_INDEX]}"
fi

if [ -z "$SELECTED" ]; then
    echo "❌ Kein passendes Wallpaper gefunden."
    exit 1
fi

# Absoluten Pfad ermitteln
SELECTED="$(realpath "$SELECTED")"

echo "🖼️ Neues Wallpaper: ${SELECTED##*/}"

# --- Anwenden ---
hyprctl hyprpaper unload all > /dev/null 2>&1
hyprctl hyprpaper preload "$SELECTED" > /dev/null 2>&1
hyprctl hyprpaper wallpaper ",$SELECTED" > /dev/null 2>&1
