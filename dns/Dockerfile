FROM ubuntu/bind9:9.20-24.10_beta

RUN apt update && apt install nano && apt-get install -y dnsutils

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
