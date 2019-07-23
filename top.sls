base:
  steevie.strugee.net:
    - apt
    - apt.backports
    - apt.equivs
    - bugzilla
    - certbot
    - cockpit
    - ejabberd
    - etckeeper
    - fail2ban
    - gopher
    - httpd
    - huginn
    - java
    - mail.postfix
    - mariadb
    - misc.build-essential
    - misc.ca-certificates
    - motd
    - nextcloud.elasticsearch
    - nextcloud.onlyoffice-db
    - ntp
    - postgres
    - redis
    - ruby
    - ruby.foreman
    - security
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
    - unattended-upgrades
  minecraft.lxd:
    - etckeeper
    - unattended-upgrades
  failover.strugee.net:
    - apt.backports
    - etckeeper
    - ntp
    - utils
    - utils.apt
    - unattended-upgrades
    - static
    - misc.ca-certificates
    - mail-failover
