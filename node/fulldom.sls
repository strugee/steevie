fulldom:
  npm.installed:
    - require:
      - npm: npm
  service.enabled:
    - require:
      - npm: fulldom
      - file: /etc/fulldom.json
      - file: /etc/systemd/system/fulldom.service

/etc/fulldom.json:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://node/fulldom.json

/etc/systemd/system/fulldom.service:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://node/fulldom.service
