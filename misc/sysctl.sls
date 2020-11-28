/etc/sysctl.conf:
  file.managed:
    - source: salt:///misc/sysctl.conf
    - mode: 644
    - user: root
    - group: root
