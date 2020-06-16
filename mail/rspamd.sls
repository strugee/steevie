rspamd:
  pkg.installed:
    - refresh: True
  service.running:
    - require:
      - pkg: rspamd
