# TODO configure Redis config file

# TODO Redis auth

redis-server:
  pkg.installed: []
  service.enabled:
    - require:
      - pkg: redis-server

redis-tools:
  pkg.installed
