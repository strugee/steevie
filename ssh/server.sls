openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ssh/sshd_config

/etc/ssh/ssh_known_hosts:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://ssh/ssh_known_hosts

ssh:
  service.enabled:
    - require:
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config
