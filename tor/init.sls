tor:
  pkg.installed

torsocks:
  pkg.removed:
    - requires:
      - pkg: tor


