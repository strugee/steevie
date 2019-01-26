postfix-debconf:
  debconf.set:
    - name: postfix
    - data:
        postfix/main_mailer_type: {'type': 'select', 'value': 'Internet Site'}
        postfix/mailname: {'type': 'string', 'value': 'strugee.net'}
        postfix/protocols: {'type': 'select', 'value': 'ipv4'}
        postfix/root_address: {'type': 'string', 'value': 'alex'}
        # TODO pull this from Pillar
        postfix/destinations: {'type': 'string', 'value': 'steevie.strugee.net, strugee.net, localhost.strugee.net, localhost'}

postfix:
  pkg.installed:
    - require:
      - postfix-debconf
  service.running:
    - require:
      - pkg: postfix

postfix-mysql:
  pkg.installed: []

postfix-ldap:
  pkg.installed: []
