# TODO perms
# TODO install CPAN modules
# TODO localconfig
# TODO build templates, etc.
# TODO depend on MySQL?
# TODO run sanitycheck.pl from cron

https://github.com/bugzilla/bugzilla.git:
  git.latest:
    - rev: release-5.0-stable
    - branch: release-5.0-stable
    - target: /srv/http/bugzilla
    - require:
      - pkg: git

/srv/http/bugzilla/localconfig:
  file.managed:
    - source: salt:///bugzilla/localconfig
    - user: root
    - group: www-data
    - mode: 640
    - template: jinja
    - require:
      - git: https://github.com/bugzilla/bugzilla.git

libmariadbclient-dev:
  pkg.installed
