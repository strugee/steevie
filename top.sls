base:
  '*':
    - etckeeper
    - unattended-upgrades
  steevie.strugee.net:
    - apt
    - apt.backports
    - apt.equivs
    - bugzilla
    - certbot
    - cockpit
    - ejabberd
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
    - node
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
    - utils
    - utils.apt
    - utils.debian
    - zfs
    - znc
  onlyoffice.lxd:
    - nextcloud.onlyoffice
  collabora-online.lxd:
    - nextcloud.collabora-online
  minecraft.lxd:
    - apt
    - java
    - minecraft
    - node.base
    - node.npm
  failover.strugee.net:
    - apt.backports
    - ntp
    - utils
    - utils.apt
    - static
    - misc.ca-certificates
    - mail-failover
