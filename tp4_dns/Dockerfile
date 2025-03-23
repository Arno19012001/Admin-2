FROM ubuntu/bind9
RUN apt update && apt install nano
COPY named.conf /etc/bind/named.conf
COPY m1-1.zone /var/cache/bind/m1-1.zone

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]

