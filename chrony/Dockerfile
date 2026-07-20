ARG BUILD_FROM
FROM ${BUILD_FROM}

RUN apk add --no-cache chrony-nts jq ca-certificates tzdata

COPY run.sh /
RUN chmod a+x /run.sh

LABEL \
    io.hass.name="Chrony" \
    io.hass.description="Chrony-based time synchronization service" \
    io.hass.type="addon"

CMD [ "/run.sh" ]
