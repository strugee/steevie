prometheus:
  pkg.installed:
    - require:
      - service: cockpit.socket

cockpit.socket:
  service.dead:
    - enable: False

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt:///prometheus/prometheus.yml
    - require:
      - pkg: prometheus
