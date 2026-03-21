#!/bin/bash

WS=$1
FOCUSED=${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}
AERO_MONITOR=$(aerospace list-workspaces --all --format '%{workspace} %{monitor-id}' | awk -v ws="$WS" '$1 == ws {print $2}')

if [ -z "$AERO_MONITOR" ]; then
  if [ "$WS" = "$FOCUSED" ]; then
    # Newly created workspace - get the currently focused monitor
    AERO_MONITOR=$(aerospace list-monitors --focused --format '%{monitor-id}' 2>/dev/null)
  fi
  if [ -z "$AERO_MONITOR" ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
  fi
fi

# Map aerospace monitor ID to sketchybar display ID
# Aerospace monitor names contain "(N)" where N is the sketchybar arrangement-id
DISPLAY=$(aerospace list-monitors --format '%{monitor-id} %{monitor-name}' | awk -v mid="$AERO_MONITOR" '$1 == mid {print $0}' | sed 's/.*(\([0-9]*\))/\1/')
DISPLAY=${DISPLAY:-$AERO_MONITOR}

if [ "$WS" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" \
    drawing=on \
    display=$DISPLAY \
    background.color=0xffcba6f7 \
    icon.color=0xff1e1e2e
else
  sketchybar --set "$NAME" \
    drawing=on \
    display=$DISPLAY \
    background.color=0x40ffffff \
    icon.color=0xffffffff
fi
