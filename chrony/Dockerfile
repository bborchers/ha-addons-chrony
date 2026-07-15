ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache chrony jq ca-certificates tzdata

COPY run.sh /
RUN chmod a+x /run.sh

LABEL \
    io.hass.name="Chrony" \
    io.hass.description="Chrony time synchronization service" \
    io.hass.type="addon"

CMD [ "/run.sh" ]
