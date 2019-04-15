base:
  steevie.strugee.net:
    - apt
    - bugzilla
    - certbot
    - cockpit
    - ejabberd
    - etckeeper
    - httpd
    - java
    - mail.postfix
    - mariadb
    - misc.build-essential
    - misc.ca-certificates
    - motd
    - nextcloud.elasticsearch
    - nextcloud.onlyoffice-db
    - postgres
    - redis
    - smartmontools
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
  onlyoffice.lxd:
    - etckeeper
    - nextcloud.onlyoffice
  collabora-online.lxd:
    - etckeeper
    - nextcloud.collabora-online
  failover.strugee.net:
    - etckeeper
    - utils
    - utils.apt
    - unattended-upgrades
    - static
    - misc.ca-certificates
    - mail-failover
