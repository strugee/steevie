# TODO store logs in /var/log
# TODO firewalld service
# TODO fix input/output handling in the systemd service, it is BROKEN currently (I think)

{% set version = 'v104.6' %}

/opt/mindustry/mindustry-{{ version }}.jar:
  file.managed:
    - source: https://github.com/Anuken/Mindustry/releases/download/{{ version }}/server-release.jar
    - source_hash: sha512=d97f82cc6fb84632fa447779ac47252f820071b216dbd460a493c80f246de512883f60e4536279315e0800098dd7be7df5870d35f9d1aa2d22137d84fe199c3a
    - makedirs: True

/opt/mindustry/config:
  file.symlink:
    - target: /var/local/mindustry

/var/local/mindustry:
  file.directory:
    - user: mindustry
    - group: mindustry

mindustry:
  group.present:
    - system: True
  user.present:
    - home: /opt/mindustry
    - createhome: False
    - shell: /sbin/nologin
    - gid_from_name: True
    - system: True
    - require:
      - group: mindustry
  # TODO this races with daemon-reload? I think?
  service.enabled:
    - require:
      - file: /etc/systemd/system/mindustry.service

/etc/systemd/system/mindustry.service:
  file.managed:
    - source: salt:///mindustry/mindustry.service
    - template: jinja
    - defaults:
      version: {{ version }}

# TODO run systemd-tmpfiles --create after this
/etc/tmpfiles.d/mindustry.conf:
  file.managed:
    - source: salt:///mindustry/tmpfiles.conf

mindustry-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/mindustry.service
