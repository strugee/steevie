lazymention:
  npm.installed:
    - require:
      - npm: npm
  service.enabled:
    - require:
      - npm: lazymention
      - file: /etc/lazymention.json
      - file: /etc/systemd/system/lazymention.service

/etc/lazymention.json:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://node/lazymention.json

# XXX should this have come from the package itself?
/etc/systemd/system/lazymention.service:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://node/lazymention.service
