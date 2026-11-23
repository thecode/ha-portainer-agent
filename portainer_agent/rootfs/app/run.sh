#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Portainer Agent
# ==============================================================================
export AGENT_SECRET

bashio::log.info 'Starting Portainer Agent...'

if bashio::config.has_value 'agent_secret'; then
    AGENT_SECRET=$(bashio::config 'agent_secret')
fi

# The agent finds its own container by hostname. Supervisor names the container
# addon_<repo>_<slug> but sets the hostname to <repo>-<slug>, so align them.
hostname "addon_${HOSTNAME/-/_}"

exec /app/agent
