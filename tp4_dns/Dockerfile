FROM internetsystemsconsortium/bind9:9.18
RUN apk update && apk add bash && apk add nano
COPY named.conf /etc/bind/named.conf
COPY m1-1.zone /etc/bind/m1-1.zone
RUN chown -R bind:bind /etc/bind
