sudo:
  pkg.installed

/etc/sudoers.d/securepath:
  file.managed:
    - source: salt://sudo/securepath
    - user: root
    - group: root
    - mode: 440
    - check_cmd: visudo -c -f
    - require:
      - pkg: sudo
