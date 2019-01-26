# TODO actually customize smartd.conf

smartmontools:
  pkg.installed:
    - require:
      # By chance I discovered that if smartmontools goes in before Postfix, it pulls in a bunch of Exim4 crap
      - pkg: postfix
      - file: /etc/smartd.conf
      - file: /etc/smartmontools

smartd:
  service.enabled:
    - require:
      - pkg: smartmontools

/etc/smartd.conf:
  file.managed:
    - source:
      - salt://smartmontools/smartd.conf
    - user: root
    - group: root
    - mode: 644

/etc/default/smartmontools:
  file.managed:
    - source:
      - salt://smartmontools/default/smartmontools
    - user: root
    - group: root
    - mode: 644

/etc/smartmontools:
  file.recurse:
    - owner: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - source: salt://smartmontools/smartmontools/

/etc/smartmontools/run.d:
  file.directory:
    - file_mode: 755
    - recurse:
      - mode
