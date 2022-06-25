# TODO this shows as unchanged even when the archive URL changes
/opt/gotify:
  archive.extracted:
    - source: https://github.com/gotify/server/releases/download/v2.1.2/gotify-linux-amd64.zip
    - source_hash: sha512=429fb732ea70d05af4a04a6ac88ad5d03ef2d4e421540d0612a5dea0f98824e388fca96f81173adcc84a8993cb9fd7f11aa49ed91297e83115459710e87de679
    - enforce_toplevel: False

gotify:
  group.present:
    - system: True
  user.present:
    - home: /opt/gotify
    - createhome: False
    - shell: /sbin/nologin
    - gid_from_name: True
    - system: True
    - require:
      - group: gotify
  # TODO this races with daemon-reload? I think?
  service.enabled:
    - require:
      - file: /etc/systemd/system/gotify.service

/etc/systemd/system/gotify.service:
  file.managed:
    - source: salt:///gotify/gotify.service

# TODO run systemd-tmpfiles --create after this
/etc/tmpfiles.d/gotify.conf:
  file.managed:
    - source: salt:///gotify/tmpfiles.conf

gotify-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/gotify.service
