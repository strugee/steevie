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

