# XXX TODO: figure out systemd service file shenanigans

strugee/offandonagain.org:
  npm.installed:
    - require:
      - npm: npm

offandonagain-org:
  service.enabled:
    - require:
      - npm: strugee/offandonagain.org
      - file: /etc/offandonagain.org.json
      - file: /etc/systemd/system/offandonagain-org.service

/etc/systemd/system/offandonagain-org.service:
  file.symlink:
    - target: /usr/lib/node_modules/offandonagain.org/offandonagain-org.service

/etc/offandonagain.org.json:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/offandonagain.org.json
