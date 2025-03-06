nano /etc/ssh/sshd_config
sudo nano /etc/ssh/sshd_config
exit
sudo whoami
ls
sudo nano /etc/ssh/sshd_config
sudo systemctl restart sshd
exit
sudo apt update
exit
ufw --version
sudo apt update && sudo apt install ufw -y
ufw --version
sudo ufw allow 50508/tcp
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
sudo ufw enable
sudo ufw status verbose
sudo apt install nmap -y
exit
netstat -nltpu
sudo apt install net-tools -y
netstat -nltpu
sudo netstat -nltpu
sudo apt update && sudo apt install fail2ban -y
sudo systemctl status fail2ban
sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban
sudo apt update
sudo systemctl status fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban
sudo nano /etc/fail2ban/jail.local
sudo systemctl status fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban
ls -lh /var/log/auth.log
sudo nano /etc/fail2ban/jail.local
sudo systemctl enable --now fail2ban
sudo systemctl restart fail2ban
sudo systemctl enable --now fail2ban
sudo systemctl status fail2ban
sudo fail2ban-client status sshd
ps -A
ps
exit
sudo fail2ban-client status sshd
exit
cd /
ls
cd usr
ls
cd local
ls
cd /
ls
cd home
ls
cd clement
ls
exit
mkdir .ssh
ls
mkdir ~/.ssh
ls -l
ls -a
ls -al
rmdir .ssh
mkdir -p ~/.ssh && chmod 700 ~/.ssh
cd .ssh
nano authorized_keys
chmod 600 ~/.ssh/authorized_keys
exit
ls
ls -a
exit
cd .ssh
ls
cat authorized_keys 
exit
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
cd .ssh
car authorized_keys 
cat authorized_keys 
nano authorized_keys 
cd .ssh
sudo nano authorized_keys
cd .ssh
ls -a
ls -l
sudo nano authorized_keys
cd .ssh
sudo nano authorized_keys
sudo systemctl restart ssh
exit
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
exit
docker run hello-world
docker image ls
docker container ls
docker run -p80:80 nginx
docker run -d -p80:80 nginx
docker container ls
docker stop elated_galois
docker container ls
docker container ls -a
docker rm elated_galois heuristic_albattani happy_yalow 
docker container ls -a
docker run -d -p80:80 --name mon_serveur_web nginx
docker container ls -a
netstat -nltpu
ufw status
ufw 
ufw ?
ufw status verbose
sudo ufw status verbose
ip a
exit
docker ps
docker stop mon_serv_web
docker ps
docker ps -a
exit
docker container ls
docker ps
ps
ps -a
ps -A
clear
exit
docker run -d --name=dns -p 53:53/udp -p 53:53/tcp internetsystemsconsortium/bind9:9.18
netstat -nltpu
ps -A
clear
docker ps
docker run -d --name=dns -p 53:53/udp -p 53:53/tcp internetsystemsconsortium/bind9:9.18
docker ps -A
docker ps -a
docker start dns
ufw status
ufw
ps -a
ps -A
clear
sudo ufw status
netstat -nltpu
docker start dns
sudo netstat -tulnp | grep ":53"
nano /etc/systemd/resolved.conf
sudo nano /etc/systemd/resolved.conf
sudo systemctl restart systemd-resolved
sudo netstat -tulnp | grep ":53"
docker start dns
dcocker ps
docker ps
netstat -nltpu
sudo netstat -nltpu
dig @localhost www.google.com
sudo apt update && sudo apt install dnsutils -y
dig @localhost www.google.com
docker exec -it dns bash
docker exec -it dns /bin/bash
docker exec -it dns sh
docker exec -it dns bash
ls
mkdir tp4_dns
cd tp4_dns/
nano Dockerfile
nano named.conf
docker build -t mon_dns .
docker image ls
docker run -d --name=dns2 -p 53:53/udp -p 53:53/tcp --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/etc_bind",target=/etc/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_cache_bind",target=/var/cache/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_lib_bind",target=/var/lib/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_log",target=/var/log mon_dns
docker run -d --name=dns2 -p 53:53/udp -p 53:53/tcp --mount type=bind,source="/Users/Home/EPHEC/bac2/admin2/dns/etc_bind",target=/etc/bind --mount type=bind,source="/Users/Home/EPHEC/bac2/admin2/dns/var_cache_bind",target=/var/cache/bind --mount type=bind,source="/Users/Home/EPHEC/bac2/admin2/dns/var_lib_bind",target=/var/lib/bind --mount type=bind,source="/Users/Home/EPHEC/bac2/admin2/dns/var_log",target=/var/log mon_dns
docker run -d --name=dns2 `
  -p 53:53/udp -p 53:53/tcp `
docker run -d --name=dns2 `                                                                                                   -p 53:53/udp -p 53:53/tcp \--mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/etc_bind",target=/etc/bind \
  --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_cache_bind",target=/var/cache/bind \
  --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_lib_bind",target=/var/lib/bind \
  --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_log",target=/var/log \
  mon_dns
docker run -d --name=dns2 -p 53:53/udp -p 53:53/tcp --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/etc_bind",target=/etc/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_cache_bind",target=/var/cache/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_lib_bind",target=/var/lib/bind --mount type=bind,source="C:/Users/Home/EPHEC/bac2/admin2/dns/var_log",target=/var/log mon_dns
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="/mnt/c/Users/Home/EPHEC/bac2/admin2/dns/etc_bind",target=/etc/bind   --mount type=bind,source="/mnt/c/Users/Home/EPHEC/bac2/admin2/dns/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="/mnt/c/Users/Home/EPHEC/bac2/admin2/dns/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="/mnt/c/Users/Home/EPHEC/bac2/admin2/dns/var_log",target=/var/log   mon_dns
cd ..
ls
mkdir dns_conf
mkdir etc_bind
mkdir var_cache_bind
mkdir var_lib_bind
mkdir var_log
ls
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="$HOME/dns_config/etc_bind",target=/etc/bind   --mount type=bind,source="$HOME/dns_config/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="$HOME/dns_config/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="$HOME/dns_config/var_log",target=/var/log   mon_dns
$HOME
ls
rmdir etc_bind
rmdir var_cache_bind
rmdir var_lib_bind
rmdir var_log
cd dns_config
mkdir etc_bind
mkdir var_cache_bind
mkdir var_lib_bind
mkdir var_log
ls
rmdir etc_bind
rmdir var_cache_bind
rmdir var_lib_bind
rmdir var_log
cd dns_conf
mkdir etc_bind
mkdir var_cache_bind
mkdir var_lib_bind
mkdir var_log
ls
cd ..
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="$HOME/dns_config/etc_bind",target=/etc/bind   --mount type=bind,source="$HOME/dns_config/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="$HOME/dns_config/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="$HOME/dns_config/var_log",target=/var/log   mon_dns
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="$HOME/dns_conf/etc_bind",target=/etc/bind   --mount type=bind,source="$HOME/dns_conf/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="$HOME/dns_conf/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="$HOME/dns_conf/var_log",target=/var/log   mon_dns
docker ps
docker stop dns
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="$HOME/dns_conf/etc_bind",target=/etc/bind   --mount type=bind,source="$HOME/dns_conf/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="$HOME/dns_conf/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="$HOME/dns_conf/var_log",target=/var/log   mon_dns
docker ps
docker container ls
docker container ls -l
docker start dns2
docker ps
docker container ls
docker container ls -l
docker start dns2
docker container ls -l
docker rm dns2
docker container ls -l
docker container ls -la
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp   --mount type=bind,source="$HOME/dns_conf/etc_bind",target=/etc/bind   --mount type=bind,source="$HOME/dns_conf/var_cache_bind",target=/var/cache/bind   --mount type=bind,source="$HOME/dns_conf/var_lib_bind",target=/var/lib/bind   --mount type=bind,source="$HOME/dns_conf/var_log",target=/var/log   mon_dns
docker container ls -la
docker rm dns2
docker container ls -la
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp  mon_dns
docker container ls -la
docker exec -it dns2 bash
docker stop dns2
docker rm dns2
docker run -d --name=dns2   -p 53:53/udp -p 53:53/tcp --mount type=bind,source="$HOME/dns_conf/etc_bind",target=/etc/bind mon_dns
docker ls
docker container ls
docker container ls -l
exit
