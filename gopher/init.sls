pygopherd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: zfs-zed

/etc/pygopherd/:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://gopher/pygopherd.conf
