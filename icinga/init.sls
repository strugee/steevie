# TODO sudo git clone https://github.com/icinga/icingaweb2-module-director /usr/share/icingaweb2/modules/director --branch v1.7.2
# TODO all the modules I enabled
# TODO /etc/icinga{,web}2
# TODO clones of ipl, director, reactbundle, incubator modules in /usr/share/...
# TODO useradd -r -g icingaweb2 -d /var/lib/icingadirector -s /bin/false icingadirector
# TODO install -d -o icingadirector -g icingaweb2 -m 0750 /var/lib/icingadirector
# icinga2-director.service systemd unit
icinga2:
  pkg.installed

icingaweb2:
  pkg.installed

icinga-ido-mysql:
  pkg.installed
