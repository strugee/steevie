pygopherd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: pygopherd

/etc/pygopherd/:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://gopher/pygopherd.conf
