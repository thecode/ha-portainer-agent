#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Portainer Agent
# ==============================================================================
export AGENT_SECRET LOG_LEVEL

bashio::log.info 'Starting Portainer Agent...'

if bashio::config.has_value 'agent_secret'; then
    AGENT_SECRET=$(bashio::config 'agent_secret')
fi

# Map the add-on log level to the agent's levels (default INFO)
case "$(bashio::config 'log_level' 'info')" in
    trace | debug) LOG_LEVEL=DEBUG ;;
    warning) LOG_LEVEL=WARN ;;
    error | fatal) LOG_LEVEL=ERROR ;;
    *) LOG_LEVEL=INFO ;;
esac

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
