openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://ssh/sshd_config

ssh:
  service.enabled:
    - require:
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config
