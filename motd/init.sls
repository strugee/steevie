/etc/motd:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://motd/motd
