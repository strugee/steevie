unattended-upgrades:
  pkg.installed: []
  service.running:
    - require:
      - pkg: unattended-upgrades

needrestart:
  pkg.installed
