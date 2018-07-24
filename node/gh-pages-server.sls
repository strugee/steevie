strugee/gh-pages-server:
  npm.installed:
    - require:
      - npm: npm
  service.enabled:
    - require:
      - npm: strugee/gh-pages-server
      - file: /etc/gh-pages-server.json
      - file: /etc/systemd/system/gh-pages-server.service

/etc/gh-pages-server.json:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/gh-pages-server.json

/etc/systemd/system/gh-pages-server.service:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://node/gh-pages-server.service
