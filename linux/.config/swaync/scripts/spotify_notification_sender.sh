#!/usr/bin/env bash

# IMAGE_PATH="/tmp/spotify_song_art"
# 
# # Follow metadata changes specifically for Spotify
# playerctl --player=spotify metadata --format '{{title}}' --follow 2>/dev/null | while read -r _; do
#     title=$(playerctl --player=spotify metadata title 2>/dev/null)
#     artist=$(playerctl --player=spotify metadata artist 2>/dev/null)
#     album=$(playerctl --player=spotify metadata album 2>/dev/null)
#     art_url=$(playerctl --player=spotify metadata mpris:artUrl)
# 
# 
#     curl -o ${IMAGE_PATH} --silent --connect-timeout 2 "${art_url}"
# 
#     # Only send if Spotify is actively playing a track
#     if [ -n "$title" ]; then
#         notify-send -a "Spotify" -u low -t 2000 -i ${IMAGE_PATH} "${title}" "${artist} — ${album}"
#     fi
# 
# done

tmp_icon=""

cleanup() {
  [[ -n "$tmp_icon" ]] && rm -f "$tmp_icon"
}
trap cleanup EXIT

playerctl --player=spotify --follow metadata --format $'{{artist}}\t{{title}}\t{{album}}\t{{mpris:artUrl}}' \
| while IFS=$'\t' read -r artist title album art_url; do
[[ -z "${title}" ]] && continue

icon="spotify"

if [[ -n "$art_url" ]]; then
  if [[ "$art_url" == file://* ]]; then
    icon="${art_url#file://}"
  elif [[ "$art_url" == http* ]]; then
    tmp_icon=$(mktemp /tmp/spotify-art-XXXXXX.jpg)
    curl -sf -o "$tmp_icon" "$art_url" && icon="$tmp_icon"
  fi
fi

notify-send --icon="${icon}" --app-name=Spotify -t 2000 "${title}" "${artist} - ${album}" --expire-time 10000
done
