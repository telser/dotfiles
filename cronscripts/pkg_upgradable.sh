#!/bin/sh

TOT=0

parse_pkg_count() {
    echo "$1" | wc -l | cut -wf2
}

print_env_info_update_total() {
    if [ -n "$3" ]; then
	PKG_NAME=$(echo "$3" | cut -wf1)
	printf "\n%s:%s\n\n%s" "$1" "$2" "$PKG_NAME"
	TOT=$((TOT + $2))
    fi
}

OUTPUT_FILE=/tmp/updates.txt

HOST_NAME=$(hostname -s)
HOST_TXT=$(doas pkg version -RUl '<')
HOST_NUM=$(parse_pkg_count "$HOST_TXT")

print_env_info_update_total "$HOST_NAME" "$HOST_NUM" "$HOST_TXT" > "$OUTPUT_FILE"

for JAIL_ID in $(jls jid); do
    JAIL_NAME=$(jls -j "$JAIL_ID" host.hostname)
    JAIL_TXT=$(doas pkg -j "$JAIL_ID" version -RUl '<')
    JAIL_NUM=$(parse_pkg_count "$JAIL_TXT")
    if [ -n "$JAIL_TXT" ]; then
	printf "\n" >> "$OUTPUT_FILE"
	print_env_info_update_total "$JAIL_NAME" "$JAIL_NUM" "$JAIL_TXT" >> "$OUTPUT_FILE"
    fi
done

printf "\n\n%s" "$TOT" >> "$OUTPUT_FILE"
