ntp:
  pkg.installed: []
  service.running:
    - require:
      - pkg: ntp
