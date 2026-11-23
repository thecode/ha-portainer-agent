# Changelog

The add-on version matches the Portainer agent version. See the
[Portainer release notes](https://github.com/portainer/portainer/releases).

## Unreleased

- Fix the agent's lookup of its own container (startup warning "No such container")
- The `log_level` option now sets the agent's log level
- Add a watchdog that restarts the add-on if the agent stops answering on port 9001

## 2.45.4

- Update Portainer agent to 2.45.4

## 2.39.1

- Build from the official `portainer/agent` image instead of a committed binary
- Include the docker CLI and credential helper shipped with the agent image
- Base image `ghcr.io/hassio-addons/base` 21.0.11
