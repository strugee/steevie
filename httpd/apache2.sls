# TODO site configurations

apache2:
  pkg.installed: []
  service.running:
    - require:
      - pkg: apache2
