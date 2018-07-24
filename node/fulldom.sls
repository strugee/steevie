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
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/fulldom.json

/etc/systemd/system/fulldom.service:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/fulldom.service
