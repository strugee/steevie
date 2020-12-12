# TODO setup - requires chown of /srv/http/polr non-recursive and cp .env.sample .env and chmod 640 .env
# TODO chown .env root:www-data
# TODO logs to /var/log
# TODO chown -R www-data /srv/http/polr/storage

polr-clone:
  git.latest:
    - name: https://github.com/cydrobolt/polr.git
    - rev: 2.2.0
    - branch: 2.2.0
    - target: /srv/http/polr
#    - require:
#      - pkg: git

/usr/local/src/equivs/polr:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://polr/polr.equivs

polr-equivs:
  cmd.run:
    - name: equivs-build /usr/local/src/equivs/polr
    - cwd: /usr/local/src/equivs/
    - creates: /usr/local/src/equivs/polr_1.0_all.deb
    - require:
      - file: /usr/local/src/equivs/polr
#      - pkg: equivs

/usr/local/src/equivs/polr_1.0_all.deb:
  pkg.installed:
    - onchanges:
      - cmd: polr-equivs

polr-composer:
  cmd.run:
    - name: 'chown -R nobody:nogroup . && sudo -u nobody composer install --no-dev -o && chown -R root:root'
    - cwd: /srv/http/polr
    - onchanges:
      - git: polr-clone
    - require:
      - file: /usr/local/src/equivs/hugin
      - git: polr-clone
      - user: polr
#      - pkg: composer

# TODO GRANT permissions for this MySQL user
polr:
  mysql_user.present:
    - host: localhost
    - password: {{ pillar['polr']['mysql_password'] }}
  mysql_database.present:
    -
