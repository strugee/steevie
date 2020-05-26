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

https://github.com/jpnurmi/znc-playback.git:
  git.detached:
    - rev: 2e32d508aa975c0a307d09575a0198f8c56c11fa
    - target: /usr/local/src/znc-playback
    - require:
      - pkg: git

/usr/local/lib/znc/:
  file.directory

# TODO chmod -x playback.so
'znc-buildmod /usr/local/src/znc-playback/playback.cpp':
  cmd.run:
    - cwd: /usr/local/lib/znc/
    - creates: /usr/local/lib/znc/playback.so
    - require:
      - file: /usr/local/lib/znc/

/var/lib/znc/.znc/modules:
  file.symlink:
    - target: /usr/local/lib/znc
    - force: True
