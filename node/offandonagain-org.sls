# XXX TODO: figure out systemd service file shenanigans

strugee/offandonagain.org:
  npm.installed:
    - require:
      - npm: npm
  service.enabled:
    - require:
      - npm: strugee/offandonagain.org
      - file: /etc/offandonagain.org.json
      - file: /etc/systemd/system/offandonagain.org.service

/etc/offandonagain.org.json:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/offandonagain.org.json
