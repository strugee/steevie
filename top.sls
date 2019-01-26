base:
  steevie.strugee.net:
    - apt
    - bugzilla
    - certbot
    - ejabberd
    - etckeeper
    - httpd
    - java
    - mail.postfix
    - mariadb
    - misc.build-essential
    - misc.ca-certificates
    - motd
    - redis
    - snapd
    - ssh.server
    - ssh.client
    - static
    - tarsnap
    - unattended-upgrades
    - utils
    - utils.apt
    - utils.debian
    - zfs
    - znc
  failover.strugee.net:
    - utils
    - utils.apt
    - unattended-upgrades
    - static
    - misc.ca-certificates
    - mail-failover
