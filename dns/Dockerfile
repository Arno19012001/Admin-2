FROM ubuntu/bind9:9.20-24.10_beta

RUN apt update && apt install nano
#COPY named.conf /etc/bind/named.conf
#COPY m1-1.zone /var/cache/bind/m1-1.zone

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
