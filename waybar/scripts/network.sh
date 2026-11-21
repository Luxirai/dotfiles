#!/bin/bash
CACHE_DIR="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}"

format_rate() {
    local bytes=$1
    local num unit

    if (( bytes >= 1073741824 )); then
        local g=$((bytes / 1073741824))
        local gd=$(( (bytes % 1073741824) * 10 / 1073741824 ))
        num="${g}.${gd}"; unit="G"
    elif (( bytes >= 104857600 )); then
        num="$((bytes / 1048576))"; unit="M"
    elif (( bytes >= 1048576 )); then
        local m=$((bytes / 1048576))
        local md=$(( (bytes % 1048576) * 10 / 1048576 ))
        num="${m}.${md}"; unit="M"
    elif (( bytes >= 102400 )); then
        num="$((bytes / 1024))"; unit="K"
    elif (( bytes >= 1024 )); then
        local k=$((bytes / 1024))
        local kd=$(( (bytes % 1024) * 10 / 1024 ))
        num="${k}.${kd}"; unit="K"
    else
        local bd=$(( bytes * 10 / 1024 ))
        num="0.${bd}"; unit="K"
    fi

    printf "%4s%s" "$num" "$unit"
}

iface=$(ip route | awk '/default/ {print $5; exit}')

if [[ -z "$iface" ]]; then
    echo '{"text": " offline", "tooltip": "No network", "class": "disconnected"}'
    exit 0
fi

CACHE="$CACHE_DIR/waybar-net-${UID}-${iface}"
now=$(date +%s)
read -r rx_now < "/sys/class/net/$iface/statistics/rx_bytes"
read -r tx_now < "/sys/class/net/$iface/statistics/tx_bytes"

rx_rate=0
tx_rate=0

if [[ -r "$CACHE" ]]; then
    read -r prev_time prev_rx prev_tx < "$CACHE"
    if [[ $prev_time =~ ^[0-9]+$ && $prev_rx =~ ^[0-9]+$ && $prev_tx =~ ^[0-9]+$ ]]; then
        elapsed=$((now - prev_time))
        if (( elapsed > 0 )); then
            (( rx_now >= prev_rx )) && rx_rate=$(( (rx_now - prev_rx) / elapsed ))
            (( tx_now >= prev_tx )) && tx_rate=$(( (tx_now - prev_tx) / elapsed ))
        fi
    fi
fi
printf '%s %s %s\n' "$now" "$rx_now" "$tx_now" > "$CACHE"

up=$(format_rate "$tx_rate")
down=$(format_rate "$rx_rate")

ip_addr=$(ip -4 addr show "$iface" 2>/dev/null | awk '/inet / {print $2; exit}')

text=" $up  $down"
tooltip="$iface  |   $up   $down  |  IP: ${ip_addr:-N/A}"

if command -v jq &>/dev/null; then
    jq -cn --arg t "$text" --arg tt "$tooltip" '{"text":$t,"tooltip":$tt}'
else
    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"
fi
