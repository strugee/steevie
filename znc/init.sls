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

znc-dev:
  pkg.installed

# TODO pin to a specific commit
https://github.com/jpnurmi/znc-playback.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /usr/local/src/znc-playback
    - require:
      - pkg: git

/usr/local/lib/znc/:
  file.directory

'znc-buildmod /usr/local/src/znc-playback/playback.cpp':
  cmd.run:
    - cwd: /usr/local/lib/znc/
    - creates: /usr/local/lib/znc/playback.so
    - require:
      - file: /usr/local/lib/znc/
