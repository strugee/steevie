base:
  '*':
    - etckeeper
    - security
    - unattended-upgrades
  # Droplets register as KVM
  'virtual:(physical|kvm)':
    - match: grain_pcre
    - cockpit
    - ntp
    - sudo
    - watchdog
  'virtual:LXC':
    - match: grain
    - utils.essential
  steevie.strugee.net:
    - apt
    - apt.backports
    - apt.equivs
    - bugzilla
    - certbot
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
    - node
    - postgres
    - redis
    - ruby
    - ruby.foreman
    - smartmontools
    - snapd
    - ssh.client
    - ssh.server
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
    - node.bunyan
    - node.minecraft-switcher
    - node.npm
  failover.strugee.net:
    - apt.backports
    - mail-failover
    - misc.ca-certificates
    - ntp
    - static
    - utils
    - utils.apt
