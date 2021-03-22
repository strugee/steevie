/etc/salt/minion.d/mysql.conf:
  file.managed:
    - source: salt:///salt/mysql.conf
