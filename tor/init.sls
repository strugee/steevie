tor:
  pkg.installed

torsocks:
  pkg.removed:
    - requires:
      - pkg: tor

/etc/tor/torrc:
  file.managed:
    - source: salt://tor/torrc

# TODO provision onion service keys to /var/lib/tor/hidden_service
