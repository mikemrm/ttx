#!/usr/bin/env bash

TALOS_PS1_PREFIX_COLOR=""
TALOS_PS1_PREFIX_TEXT="("
TALOS_PS1_SEPERATOR_COLOR=""
TALOS_PS1_SEPERATOR_TEXT="|"
TALOS_PS1_SYMBOL_COLOR="\x1b[38;2;255;106;0m"
TALOS_PS1_SYMBOL_TEXT="⸩⸨"
TALOS_PS1_CONTEXT_COLOR="\x1b[38;2;56;94;105m"
TALOS_PS1_SUFFIX_COLOR=""
TALOS_PS1_SUFFIX_TEXT=")"
TALOS_PS1_COLOR_RESET="\x1b[0m"

_talos_ps1_current_context() {
    local talosconfig

    if [ -z "$talosconfig" ]; then
        talosconfig="$HOME/.talos/config"

        if [ ! -e "$talosconfig" ]; then
            talosconfig="/var/run/secrets/talos.dev/config"
        fi
    fi

    if [ ! -e "$talosconfig" ]; then
        echo "talos config not found. Define 'TALOSCONFIG' env variable or create a config in \$HOME/.talos/config or /var/run/secrets/talos.dev/config" >&2

        return
    fi

    yq -r '.context // ""' "$talosconfig"
}

taloson() {
    ENABLE_TALOS_PS1=true
}

talosoff() {
    ENABLE_TALOS_PS1=false
}

talos_ps1() {
    local output
    if [[ "${ENABLE_TALOS_PS1:-false}" == "true" ]]; then
        output="${TALOS_PS1_PREFIX_COLOR}${TALOS_PS1_PREFIX_TEXT}${TALOS_PS1_COLOR_RESET}"
        output+="${TALOS_PS1_SYMBOL_COLOR}${TALOS_PS1_SYMBOL_TEXT}${TALOS_PS1_COLOR_RESET}"
        output+="${TALOS_PS1_SEPERATOR_COLOR}${TALOS_PS1_SEPERATOR_TEXT}${TALOS_PS1_COLOR_RESET}"
        output+="${TALOS_PS1_CONTEXT_COLOR}$(_talos_ps1_current_context)${TALOS_PS1_COLOR_RESET}"
        output+="${TALOS_PS1_SUFFIX_COLOR}${TALOS_PS1_SUFFIX_TEXT}${TALOS_PS1_COLOR_RESET}"

        printf "$output"
    fi
}
