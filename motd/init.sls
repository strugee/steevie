/etc/motd:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://motd/motd
