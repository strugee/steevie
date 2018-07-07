mariadb-server:
  pkg.installed: []
  service.running:
    - name: mariadb
    - require:
      - pkg: mariadb-server

mariadb-client:
  pkg.installed
