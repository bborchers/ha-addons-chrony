#!/usr/bin/with-contenv bashio
# ============================================================================
# Starts the Chrony add-on
# ============================================================================

set -euo pipefail

CONFIG_DIR="/data/chrony"
CONFIG_FILE="${CONFIG_DIR}/chrony.conf"

mkdir -p "${CONFIG_DIR}/logs"

bashio::log.info "Starting Chrony..."

mapfile -t SERVERS < <(jq -r '.servers[]? // empty' /data/options.json)
NTS_ENABLED="$(bashio::config 'nts')"

if [ "${#SERVERS[@]}" -eq 0 ]; then
    if bashio::config.true 'nts'; then
        SERVERS=("time.cloudflare.com")
    else
        SERVERS=("pool.ntp.org")
    fi
fi

{
    echo "driftfile ${CONFIG_DIR}/chrony.drift"
    echo "rtcsync"
    echo "makestep 1.0 3"
    echo "logdir ${CONFIG_DIR}/logs"

    if bashio::config.true 'nts'; then
        SOURCE_OPTIONS="nts iburst"
    else
        SOURCE_OPTIONS="iburst"
    fi

    for server in "${SERVERS[@]}"; do
        echo "server ${server} ${SOURCE_OPTIONS}"
    done
} > "${CONFIG_FILE}"

bashio::log.info "Configured NTP servers: ${SERVERS[*]}"
bashio::log.info "NTS enabled: ${NTS_ENABLED}"

exec chronyd -d -f "${CONFIG_FILE}"
