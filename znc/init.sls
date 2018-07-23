# TODO configure ZNC config file

znc:
  pkg.installed: []
  group.present:
    # Historical
    - gid: 993
    - system: True
  user.present:
    - fullname: ZNC
    # Historical
    - uid: 994
    - gid: 993
    - gid_from_name: True
    - home: /var/lib/znc
    - createhome: True
    # TODO maybe change this
    - shell: /bin/sh
    - system: True
    - require:
      - group: znc
  service.enabled:
    - require:
      - file: /etc/systemd/system/znc.service
      - user: znc
      - group: znc
      - pkg: znc

/etc/systemd/system/znc.service:
  file.managed:
    - source: salt://znc/znc.service
    - user: root
    - group: root
    - mode: 644
