/opt/gotify:
  archive.extracted:
    - source: https://github.com/gotify/server/releases/download/v2.0.19/gotify-linux-amd64.zip
    - source_hash: sha512=4b45508982ce31f2586a523617a19957b3c61193d063251bb66d0adcd9ad460893c50a3ac8880fdd5091d1e2680d448314f0ecfa563b3b0c806d9400c3578f73
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
