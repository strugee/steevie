# TODO apt-mark auto

{% for pkg in ['dovecot-mysql', 'dovecot-pop3d', 'dovecot-imapd', 'dovecot-lmtpd', 'dovecot-managesieved'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

dovecot:
  service.running:
    - require:
      - pkg: dovecot-imapd # Pulls in dovecot-core
