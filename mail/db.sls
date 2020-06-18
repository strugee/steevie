# TODO do a dry run of this state to make sure it's OK

mailserver:
  mysql_database.present

mailadmin:
  mysql_user.present:
    - host: localhost
    - password: {{ pillar['mail']['mysql_mailadmin_password'] }}

mailserver:
  mysql_user.present:
    - host: 127.0.0.1
    - password: {{ pillar['mail']['mysql_mailserver_password'] }}

# TODO tables
