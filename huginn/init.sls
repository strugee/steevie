huginn-clone:
  git.latest:
    - name: https://github.com/huginn/huginn.git
    - target: /srv/http/huginn
    - require:
      - pkg: git

/usr/local/src/equivs:
  file.directory

/usr/local/src/equivs/huginn:
  file.managed:
    - owner: root
    - group: root
    - mode: 644
    - source: salt://huginn/huginn.equivs

huginn-equivs:
  cmd.run:
    - name: equivs-build /usr/local/src/equivs/huginn
    - cwd: /usr/local/src/equivs/
    - creates: /usr/local/src/equivs/huginn_1.0_all.deb
    - require:
      - file: /usr/local/src/equivs/huginn
      - pkg: equivs

/usr/local/src/equivs/huginn_1.0_all.deb:
  pkg.installed:
    - onchanges:
      - cmd: huginn-equivs

huginn:
  group.present:
    # Historical
    - gid: 996
    - system: True
  user.present:
    - fullname: Huginn
    # Historical
    - uid: 126
    - gid: 996
    - gid_from_name: True
    - home: /srv/http/huginn
    - createhome: False
    - shell: /bin/false
    - system: True
    - require:
      - group: huginn

# TODO create MySQL user and grant permissions

# TODO manage this with SaltStack
/etc/huginn.conf:
  file.managed:
    - user: root
    - group: huginn
    - mode: 640
    - require:
      - group: huginn
    # TODO remove these
    - create: False
    - replace: False

/srv/http/huginn/.env:
  file.symlink:
    - target: /etc/huginn.conf

huginn-writable-dirs:
  file.directory:
    - user: huginn
    - group: huginn
    - dir_mode: 755
    - recurse:
      - user
      - group
      - mode
    - names:
      - /srv/http/huginn/log
      - /srv/http/huginn/tmp
      - /srv/http/huginn/tmp/pids
      - /srv/http/huginn/tmp/sockets
    - require:
      - git: huginn-clone

/srv/http/huginn/config/unicorn.rb:
  file.managed:
    - source: salt://huginn/unicorn.rb
    - require:
      - git: huginn-clone

huginn-bundler:
  cmd.run:
    - name: 'chown -R huginn:huginn . && sudo -u huginn -H bundle install --deployment --without test development'
    - cwd: /srv/http/huginn
    - creates: /srv/http/huginn/vendor/bundle
    - require:
      - file: /usr/local/src/equivs/huginn
      - git: huginn-clone
      - user: huginn
      - pkg: bundler

# Weird imperative states to ensure that permissions get fixed after a Bundler run
# We can't use onchanges directly in the file.directory states because then they wouldn't run if there wasn't a Bundler run
huginn-root-perms:
  file.directory:
    - name: /srv/http/huginn
    - user: root
    - group: root
    - recurse:
      - user
      - group
    - onchanges:
      - cmd: huginn-bundler
    - require:
      - git: huginn-clone

huginn-bundle-perms-postscript-dirs:
  file.directory:
    - onchanges:
      - file: huginn-root-perms
    - use:
      - file: huginn-writable-dirs

huginn-bundle-perms-postscript-unicorn:
  file.managed:
    - onchanges:
      - file: huginn-root-perms
    - use:
      - file: /srv/http/huginn/config/unicorn.rb

# TODO create db if needed

# TODO db migration

# TODO seed db if needed

huginn-assets-precompile:
  cmd.run:
    - name: 'bundle exec rake assets:precompile RAILS_ENV=production'
    - cwd: /srv/http/huginn
    - onchanges:
      - git: huginn-clone
    - require:
      - cmd: huginn-bundler

/srv/http/huginn/Procfile:
  file.managed:
    - source: salt://huginn/Procfile
    - require:
      - git: huginn-clone

huginn-foreman:
  cmd.run:
    - name: 'foreman export -a huginn -u huginn -m web=2,jobs=2 systemd /etc/systemd/system && systemctl daemon-reload'
    - cwd: /srv/http/huginn
    - require:
      - pkg: ruby-foreman
    - onchanges:
      - file: /srv/http/huginn/Procfile

huginn.target:
  service.enabled:
    - require:
      - cmd: huginn-foreman

huginn-logrotate:
  file.copy_:
    - name: /etc/logrotate.d/huginn
    - source: /srv/http/huginn/deployment/logrotate/huginn

huginn-logrotate-patch:
  file.patch:
    - name: /etc/logrotate.d/huginn
    - source: salt://huginn/huginn-logrotate.patch
