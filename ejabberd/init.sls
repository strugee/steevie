# TODO dpkg-statoverride --add root shadow 02755 /usr/lib/erlang/p1_pam/bin/epam

ejabberd:
  pkg.installed: []
  service.enabled:
    - require:
      - pkg: ejabberd
      - file: /etc/ejabberd/ejabberd.yml

# TODO apt-mark auto

erlang-p1-pam:
  pkg.installed

erlang-p1-stun:
  pkg.installed

/etc/ejabberd/ejabberd.yml:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ejabberd/ejabberd.yml

/etc/systemd/system/ejabberd.service.d/override.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - makedirs: True
    - source: salt://ejabberd/systemd-override.conf

# TODO create MySQL database and user
