# TODO DRY up this file
# TODO should this be shared with regular mail?
postfix-debconf:
  debconf.set:
    - name: postfix
    - data:
        postfix/main_mailer_type: {'type': 'select', 'value': 'Internet Site'}
        postfix/mailname: {'type': 'string', 'value': 'strugee.net'}
        postfix/protocols: {'type': 'select', 'value': 'ipv4'}

postfix:
  pkg.installed:
    - require:
      - postfix-debconf
  service.running:
    - require:
      - pkg: postfix
      - file: /etc/mailname
      - file: /etc/postfix/master.cf
      - file: /etc/postfix/main.cf

/etc/mailname:
  file.managed:
    - source:
      - salt://mail-failover/mailname
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: postfix

/etc/postfix/master.cf:
  file.managed:
    - source:
      - salt://mail-failover/postfix/master.cf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: postfix

/etc/postfix/main.cf:
  file.managed:
    - source:
      - salt://mail-failover/postfix/main.cf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: postfix
