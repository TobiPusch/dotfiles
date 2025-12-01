#!/bin/bash

# --- Einstellungen ---
WALLPAPER_DIR="$HOME/.config/wallpaper/Images"

# --- Alle Bilder finden ---
# Wir suchen nach jpg, jpeg und png
readarray -t ALL_IMAGES < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

# --- Auswahl-Logik ---
if [ -n "$1" ]; then
    # FALL 1: Suchbegriff vorhanden
    # Wir filtern mit fzf, nehmen aber aus den Treffern ein ZUFÄLLIGES (shuf -n 1)
    SELECTED=$(printf "%s\n" "${ALL_IMAGES[@]}" | fzf --filter="$1" | shuf -n 1)
else
    # FALL 2: Keine Eingabe -> Komplett zufälliges Wallpaper
    
    # Aktuelles Wallpaper herausfinden (um es auszuschließen)
    CURRENT_WALL=$(hyprctl hyprpaper listloaded | awk '{print $2}' | head -n 1)
    CURRENT_BASENAME=$(basename "$CURRENT_WALL" 2>/dev/null)

    # Suche alle Bilder, die NICHT das aktuelle sind, und wähle zufällig eins (shuf)
    SELECTED=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_BASENAME" \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | shuf -n 1)
fi

# --- Prüfen ob was gefunden wurde ---
if [ -z "$SELECTED" ]; then
    echo "❌ Kein passendes Wallpaper gefunden."
    exit 1
fi

# Absoluten Pfad sicherstellen
SELECTED="$(realpath "$SELECTED")"

echo "🖼️ Neues Wallpaper: ${SELECTED##*/}"

# --- Anwenden ---
# Hyprpaper Logik: Erst preloaden, dann setzen, dann alten unloaden (um Flackern zu minimieren)
hyprctl hyprpaper preload "$SELECTED" > /dev/null 2>&1
hyprctl hyprpaper wallpaper ",$SELECTED" > /dev/null 2>&1

# Kleiner Workaround: Hyprpaper braucht kurz, bevor man das alte unloaden kann,
# sonst wird das neue manchmal mit entfernt, wenn man sehr schnell switcht.
# Da wir keine Loop mehr haben, ist 'unload all' am Ende okay, aber wir wollen das neue behalten.
# Besser: Nur das alte unloaden, aber 'unload all' ist robuster gegen Speicherlecks.
# Wir lassen unload all hier weg und verlassen uns darauf, dass beim nächsten Aufruf das 'alte' ja ersetzt wird.
# Wenn du Speicher sparen willst, kannst du VOR dem preload 'unload all' machen (führt aber kurz zu schwarz/default).

# Option A (Speicherschonend, kann kurz flackern):
# hyprctl hyprpaper unload all > /dev/null 2>&1
# hyprctl hyprpaper preload "$SELECTED" > /dev/null 2>&1
# hyprctl hyprpaper wallpaper ",$SELECTED" > /dev/null 2>&1

# Option B (Smoother Übergang, wir unloaden einfach alles was NICHT das neue ist):
# (Das ist etwas komplexer in bash, daher bleiben wir bei deiner ursprünglichen Reihenfolge,
# aber optimiert für Zufall)

hyprctl hyprpaper unload all > /dev/null 2>&1
hyprctl hyprpaper preload "$SELECTED" > /dev/null 2>&1
hyprctl hyprpaper wallpaper ",$SELECTED" > /dev/null 2>&1
