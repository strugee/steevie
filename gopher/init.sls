pygopherd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: pygopherd

/etc/pygopherd/:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://gopher/pygopherd.conf
