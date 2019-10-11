# TODO ensure contrib components are enabled here

/etc/apt/preferences.d/10-no-prefer-contrib:
  file.managed:
    - source: salt://apt/10-no-prefer-contrib
