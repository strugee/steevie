# TODO should we really be joined to the earth network? Because we are in prod

zerotier-repo:
  pkgrepo.managed:
    - name: "deb http://download.zerotier.com/debian/buster buster main"
    - file: /etc/apt/sources.list.d/zerotier.list
    - key_url: salt://zerotier/zerotier.asc
    - require_in:
      - pkg: zerotier-one

zerotier-one:
  pkg.installed:
    - refresh: True
  service.running:
    - enable: True
    - require:
      - pkg: zerotier-one

'zerotier-cli join a09acf023372e4be':
  cmd.run:
    - require:
      - service: zerotier-one
