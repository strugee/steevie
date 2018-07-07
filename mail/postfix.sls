postfix:
  pkg.installed: []
  service.running:
    - require:
      - pkg: postfix

postfix-mysql:
  pkg.installed: []

postfix-ldap:
  pkg.installed: []
