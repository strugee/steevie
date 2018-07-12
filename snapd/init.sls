snapd:
  pkg.installed: []
  service.running:
    - require:
      - pkg: snapd
