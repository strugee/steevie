# TODO matterbridge.toml

/opt/matterbridge/bin/matterbridge:
  file.managed:
    - source: https://github.com/42wim/matterbridge/releases/download/v1.17.2/matterbridge-1.17.2-linux-64bit
    - source_hash: sha512=132cae16d58b423a7282d40456139f4317993bb6e4d0487ca0299b92b244405abf164678feee3251ff9ded232eb005a5f2287e68334703b75d77d8482e685265
    - makedirs: True
    - mode: 755

matterbridge:
  group.present:
    - system: True
  user.present:
    - home: /opt/matterbridge
    - createhome: False
    - shell: /sbin/nologin
    - gid_from_name: True
    - system: True
    - require:
      - group: matterbridge
  # TODO this races with daemon-reload? I think?
  service.enabled:
    - require:
      - file: /etc/systemd/system/matterbridge.service

/etc/systemd/system/matterbridge.service:
  file.managed:
    - source: salt:///matterbridge/matterbridge.service

matterbridge-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/matterbridge.service
