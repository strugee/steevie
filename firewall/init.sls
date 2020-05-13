# TODO actually manage what ports are open

firewalld:
  pkg.installed

/etc/firewalld/firewalld.conf:
  file.managed:
    - source: salt://firewall/firewalld.conf
    - require:
      - pkg: firewalld
