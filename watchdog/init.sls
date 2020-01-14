watchdog:
  pkg.installed: []
  service.enabled:
    - require:
      - pkg: watchdog
