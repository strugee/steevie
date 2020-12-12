prometheus:
  pkg.installed:
    - require:
      - service: cockpit.socket

cockpit.socket:
  service.dead:
    - enable: False
