ARG BUILD_FROM=ghcr.io/hassio-addons/base:21.0.11
# Supervisor passes the add-on version from config.json; it is the Portainer agent version
ARG BUILD_VERSION

FROM portainer/agent:${BUILD_VERSION} AS agent

FROM ${BUILD_FROM}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Agent, docker CLI, credential helper and edge UI, straight from the official image
COPY --from=agent /app /app
COPY --from=agent /root/.docker/config.json /root/.docker/config.json

ENV PATH="/app:${PATH}"

COPY rootfs /
RUN chmod a+x /app/run.sh

WORKDIR /app
CMD [ "/app/run.sh" ]
