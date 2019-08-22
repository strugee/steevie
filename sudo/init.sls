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

/etc/sudoers.d/insults:
  file.managed:
    - use: /etc/sudoers.d/securepath
    - source: salt://sudo/insults
