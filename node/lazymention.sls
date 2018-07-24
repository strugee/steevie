lazymention:
  npm.installed:
    - require:
      - npm: npm

/etc/lazymention.json:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/lazymention.json
