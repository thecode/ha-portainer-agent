#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Portainer Agent
# ==============================================================================
export AGENT_SECRET

bashio::log.info 'Starting Portainer Agent...'

if bashio::config.has_value 'agent_secret'; then
    AGENT_SECRET=$(bashio::config 'agent_secret')
fi

# The agent looks up its own container by hostname. Supervisor's hostname is not
# the container name, and the name format changes between Supervisor versions,
# so use the container ID (12 chars, like Docker's default hostname).
container_id=$(grep -o -m1 '/containers/[0-9a-f]\{64\}/' /proc/self/mountinfo | cut -d/ -f3)
if [[ -n "${container_id}" ]]; then
    hostname "${container_id:0:12}"
else
    bashio::log.warning 'Container ID not found, keeping hostname'
fi

exec /app/agent
