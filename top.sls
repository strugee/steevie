base:
  '*':
    - cockpit
    - etckeeper
    - osquery
    - prometheus.node-exporter
    - security
    - unattended-upgrades
  # Droplets register as KVM
  'virtual:(physical|kvm)':
    - match: grain_pcre
    - firewall
    - misc.coredump
    - misc.doc
    - misc.sysctl
    - misc.systemd-crash-reboot
    - ntp
    - sudo
    - watchdog
  'virtual:LXC':
    - match: grain
    - misc.fakesudo
    - misc.disable-smartd
    - utils.nano
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
    - gotify
    - httpd
    - huginn
    - java
    - librephotos
    - mail.postfix
    - mail.mailman
    - mariadb
    - mindustry
    - misc.build-essential
    - misc.ca-certificates
    - motd
    - nextcloud.elasticsearch
    - nextcloud.onlyoffice-db
    - node
    - peertube
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
    - misc.unzip
  minecraft-beta.lxd:
    - apt
    - java
    - minecraft
    - node.base
    - node.bunyan
    - node.minecraft-switcher
    - node.npm
    - misc.unzip
  jellyfin.lxd:
    - jellyfin
  thelounge.lxd:
    - apt
    - node.base
    - sudo
    - thelounge
  zerotier.lxd:
    - zerotier
  bitwarden.lxd:
    - bitwarden
    - docker
  prometheus.lxd:
    - prometheus
  grafana.lxd:
    - grafana
  lxdui.lxd:
    - lxdui
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
