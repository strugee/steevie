snapd:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: snapd
