# Portainer Agent add-on for Home Assistant

Runs the [Portainer agent](https://docs.portainer.io/admin/environments/add/docker/agent)
on Home Assistant OS so a Portainer server can manage its Docker host. amd64 only.

The image is built on the Home Assistant host from the official `portainer/agent`
image. The add-on version in `portainer_agent/config.json` is the Portainer agent
version, so changing that one line is a full update.

## Install

Settings → Add-ons → Add-on store → ⋮ → Repositories, add
`https://github.com/thecode/ha-portainer-agent`.

## Updates

Renovate opens a PR when a new `portainer/agent` version is published. Merge it,
update the dev instance first, then prod.
