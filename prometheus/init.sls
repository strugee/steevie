prometheus:
  pkg.installed

cockpit.socket:
  service.dead:
    - enable: False
