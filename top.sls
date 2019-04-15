base:
  steevie.strugee.net:
    - apt
    - apt.backports
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
    - apt.backports
    - etckeeper
    - utils
    - utils.apt
    - unattended-upgrades
    - static
    - misc.ca-certificates
    - mail-failover
