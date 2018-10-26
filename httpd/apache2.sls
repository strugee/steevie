apache2:
  pkg.installed: []
# TODO
#    - require:
#      - file: /etc/apache2
  service.running:
    - require:
      - pkg: apache2
