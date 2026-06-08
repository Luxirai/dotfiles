#!/bin/bash
CACHE="/tmp/.waybar_net_cache"

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

now=$(date +%s%N)
read -r rx_now < "/sys/class/net/$iface/statistics/rx_bytes"
read -r tx_now < "/sys/class/net/$iface/statistics/tx_bytes"

rx_rate=0
tx_rate=0

if [[ -f "$CACHE" ]]; then
    read -r prev_time prev_rx prev_tx < "$CACHE"
    elapsed_ns=$(( now - prev_time ))
    if (( elapsed_ns > 0 )); then
        elapsed_s=$(echo "scale=9; $elapsed_ns / 1000000000" | bc)
        rx_rate=$(echo "($rx_now - $prev_rx) / $elapsed_s" | bc 2>/dev/null)
        tx_rate=$(echo "($tx_now - $prev_tx) / $elapsed_s" | bc 2>/dev/null)
    fi
fi

echo "$now $rx_now $tx_now" > "$CACHE"

(( rx_rate < 0 )) && rx_rate=0
(( tx_rate < 0 )) && tx_rate=0

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
