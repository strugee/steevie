base:
  '*':
    - cockpit
    - etckeeper
    - osquery
    - security
    - unattended-upgrades
  # Droplets register as KVM
  'virtual:(physical|kvm)':
    - match: grain_pcre
    - firewall
    - misc.coredump
    - ntp
    - sudo
    - watchdog
  'virtual:LXC':
    - match: grain
    - misc.fakesudo
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
    - mail.mailman
    - mariadb
    - misc.build-essential
    - misc.ca-certificates
    - motd
    - nextcloud.elasticsearch
    - nextcloud.onlyoffice-db
    - node
    - postgres
    - redis
    - rsync
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
  minecraft-beta.lxd:
    - apt
    - java
    - node.base
    - node.bunyan
    - node.minecraft-switcher
    - node.npm
  jellyfin.lxd:
    - jellyfin
  thelounge.lxd:
    - apt
    - node.base
    - sudo
    - thelounge
  zerotier.lxd:
    - zerotier
  failover.strugee.net:
    - apt
    - apt.backports
    - certbot
    - mail-failover
    - misc.ca-certificates
    - ntp
    - rsync
    - static
    - utils
    - utils.apt
