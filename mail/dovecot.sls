# TODO apt-mark auto

{% for pkg in ['dovecot-mysql', 'dovecot-pop3d', 'dovecot-imapd', 'dovecot-lmtpd', 'dovecot-managesieved'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

dovecot:
  service.running:
    - require:
      - pkg: dovecot-imapd # Pulls in dovecot-core

vmail:
  group.present:
    - system: True
  user.present:
    - home: /var/vmail
    - createhome: False
    - shell: /sbin/nologin
    - gid_from_name: True
    - system: True
    - require:
      - group: vmail

/var/vmail:
  file.directory:
    - user: vmail
    - group: vmail
    - recurse:
      - user
      - group
    - require:
      - user: vmail
      - group: vmail
