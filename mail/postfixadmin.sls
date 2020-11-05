postfixadmin-debconf:
  debconf.set:
    - name: postfixadmin
    - data:
        # TODO do we need more here?
        postfixadmin/database-type: {'type': 'select', 'value': 'mysql'}
        postfixadmin/dbconfig-install: {'type': 'boolean', 'value': 'true'}

postfixadmin:
  pkg.installed:
    require:
      - debconf: postfixadmin-debconf

/usr/share/postfixadmin/templates_c:
  file.directory:
    - user: root
    - group: www-data
    - mode: 775
    - require:
      - pkg: postfixadmin
      - pkg: apache2

/etc/postfixadmin.dbconfig.inc.php:
  file.replace:
    - pattern: "$dbtype='mysql';"
    - repl: "$dbtype='mysqli';"
    - require:
      - pkg: postfixadmin

/etc/postfixadmin/config-setuppassword.local.php:
  file.managed:
    - source: salt://mail/postfixadmin/config-setuppassword.local.php
    - user: root
    - group: www-data
    - mode: 640
    - template: jinja
    - require:
      - pkg: postfixadmin
      - pkg: apache2

/etc/postfixadmin/config-setuppassword.local.php:
  file.managed:
    - source: salt://mail/postfixadmin/config-setuppassword.local.php
    - user: root
    - group: www-data
    - mode: 640
    - require:
      - pkg: postfixadmin
      - pkg: apache2
