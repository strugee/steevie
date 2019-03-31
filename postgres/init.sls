postgresql:
  pkg.installed: []
  service.running:
    - name: postgresql
    - require:
      - pkg: postgresql
