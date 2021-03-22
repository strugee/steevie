pixelfed:
  group.present:
    - system: True
  user.present:
    - fullname: Pixelfed
    - gid_from_name: True
    - home: /srv/http/pixelfed
    - shell: /usr/sbin/nologin
    - system: True
    - require:
      - group: pixelfed
  # TODO GRANT ALL permissions for this MySQL user
  mysql_user.present:
    - host: localhost
    - password: {{ pillar['pixelfed']['mysql_password'] }}
  mysql_database.present:
    -

/etc/pixelfed.conf:
  file.managed:
    - source: salt:///pixelfed/pixelfed.env
    - user: root
    - group: pixelfed
    - mode: 660
    - template: jinja

/srv/http/pixelfed/.env:
  file.symlink:
    - target: /etc/pixelfed.conf

/srv/http/pixelfed:
  file.directory:
    # TODO this seems bad; upstream made me do it
    # If you change this, change the composer chown -R command too
    - user: pixelfed
    - group: pixelfed

pixelfed-clone:
  git.detached:
    - name: https://github.com/pixelfed/pixelfed.git
    - rev: v0.10.10
    - user: pixelfed
    - target: /srv/http/pixelfed
    - require:
#      - pkg: git
       - user: pixelfed
       - file: /srv/http/pixelfed

/usr/local/src/equivs/pixelfed:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://pixelfed/pixelfed.equivs

pixelfed-equivs:
  cmd.run:
    - name: equivs-build /usr/local/src/equivs/pixelfed
    - cwd: /usr/local/src/equivs/
    - creates: /usr/local/src/equivs/pixelfed_1.0_all.deb
    - require:
      - file: /usr/local/src/equivs/pixelfed
#      - pkg: equivs

/usr/local/src/equivs/pixelfed_1.0_all.deb:
  pkg.installed:
    - onchanges:
      - cmd: pixelfed-equivs

pixelfed-composer:
  cmd.run:
    - name: 'chown -R nobody:nogroup . && sudo -u nobody composer install --no-ansi --no-interaction --optimize-autoloader && chown -R pixelfed:pixelfed'
    - cwd: /srv/http/pixelfed
    - onchanges:
      - git: pixelfed-clone
    - require:
      - file: /usr/local/src/equivs/pixelfed
      - git: pixelfed-clone
      - user: pixelfed
#      - pkg: composer

# TODO configure pixelfed .env

/etc/redis/redis-pixelfed.conf:
  file.managed:
    - source: salt://pixelfed/redis-pixelfed.conf
    - user: redis
    - group: redis
    - mode: 640

# TODO onchanges systemctl daemon-reload
# TODO DRY this up
/etc/systemd/system/redis-server@pixelfed.service.d/override.conf:
  file.managed:
    - makedirs: True
    - source: salt://pixelfed/redis-systemd-override.conf

redis-server@pixelfed:
  service.running:
    - enable: True
    - require:
      - file: /etc/redis/redis-pixelfed.conf
#      - file: /etc/systemd/system/redis-server@pixelfed.service.d/override.conf

# TODO onchanges systemctl daemon-reload
/etc/systemd/system/pixelfed-horizon.service:
  file.managed:
    - makedirs: True
    - source: salt://pixelfed/pixelfed-horizon.service

pixelfed-horizon:
  service.running:
    - enable: true
    - require:
      - file: /etc/systemd/system/pixelfed-horizon.service

# TODO `php artisan storage:link`
# TODO `php artisan migrate --force`
# TODO `php artisan import:cities`
# TODO `php artisan instance:actor`
# TODO `php artisan passport:keys`
# TODO `php artisan route:cache`
# TODO `php artisan view:cache`
# TODO `php artisan config:cache` when .env changes
# TODO `php artisan horizon:install`
# TODO `php artisan horizon:publish`
# TODO `php artisan `

# TODO cronjob entry
