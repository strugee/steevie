phpmyadmin-debconf:
  debconf.set:
    - name: postfix
    - data:
        phpmyadmin/mysql/admin-user: {'type': 'string', 'value': 'root'}
        phpmyadmin/reconfigure-webserver: {'type': 'multiselect', 'value': 'apache2'}
        postfix/dbconfig-install: {'type': 'boolean', 'value': 'true'}


phpmyadmin:
  pkg.installed:
    - require:
      - phpmyadmin-debconf
