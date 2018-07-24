openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - owner: root
    - group: root
    - mode: 644

ssh:
  service.enabled:
    - require:
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config
