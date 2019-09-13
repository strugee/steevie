strugee/minecraft-switcher:
  npm.installed:
    - require:
      - npm: npm

minecraft-switcher:
  service.enabled:
    - require:
      - npm: strugee/minecraft-switcher
      - file: /etc/minecraft-switcher.json
      - file: /etc/systemd/system/minecraft-switcher.service
#      - file: /var/lib/local/minecraft-switcher

/var/lib/local/minecraft-switcher:
  file.directory:
    - makedirs: True

/etc/systemd/system/minecraft-switcher.service:
  file.symlink:
    - target: /usr/lib/node_modules/minecraft-switcher/minecraft-switcher.service

# TODO cause it has a secret
#/etc/minecraft-switcher.json:
#  file.managed:
#    - user: root
#    - group: root
#    - mode: 644
#    - source: salt://node/minecraft-switcher.json
