openssh-client:
  pkg.installed

/etc/ssh/ssh_config:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
