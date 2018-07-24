# TODO apt-mark auto for dovecot-core

{% for pkg in ['dovecot-core', 'dovecot-mysql', 'dovecot-pop3d', 'dovecot-imapd', 'dovecot-lmtpd', 'dovecot-managesieved'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

dovecot:
  service.running:
    - require:
      - pkg: dovecot-core
      - file: /etc/dovecot/dovecot.conf
      - file: /etc/dovecot/conf.d/10-auth.conf
      - file: /etc/dovecot/conf.d/10-mail.conf
      - file: /etc/dovecot/conf.d/10-master.conf

/etc/dovecot/dovecot.conf:
  file.managed:
    - source:
      - salt://mail-failover/dovecot/dovecot.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dovecot-core

/etc/dovecot/conf.d/10-master.conf:
  file.managed:
    - source:
      - salt://mail-failover/dovecot/conf.d/10-master.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dovecot-core

/etc/dovecot/conf.d/10-mail.conf:
  file.managed:
    - source:
      - salt://mail-failover/dovecot/conf.d/10-mail.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dovecot-core

/etc/dovecot/conf.d/10-auth.conf:
  file.managed:
    - source:
      - salt://mail-failover/dovecot/conf.d/10-auth.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: dovecot-core
