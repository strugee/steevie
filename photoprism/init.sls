# TODO create LXD container
# TODO sudo lxc config device add photoprism mariadbproxy proxy bind=instance listen=tcp:127.0.0.1:3306 connect=tcp:127.0.0.1:3306

/root/docker-compose.yml:
  file.managed:
    - source: salt:///photoprism/docker-compose.yml
    - user: root
    - group: root
    - template: jinja
    - mode: 755

# TODO GRANT permissions for this MySQL user
photoprism:
  mysql_user.present:
    - host: '%'
    - password: {{ pillar['photoprism']['mysql_password'] }}
  mysql_database.present:
    -

# TODO provision config files with secrets
