rspamd-repo:
  pkgrepo.managed:
    - name: "deb http://rspamd.com/apt-stable/ stretch main"
    - file: /etc/apt/sources.list.d/rspamd.list
    - key_url: salt://mail/rspamd.key
    - require_in:
      - pkg: rspamd

rspamd:
  pkg.installed:
    - refresh: True
  service.running:
    - require:
      - pkg: rspamd
