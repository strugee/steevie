# TODO perms
# TODO install libmariadbclient-dev
# TODO install CPAN modules
# TODO localconfig
# TODO build templates, etc.
# TODO depend on MySQL?

https://github.com/bugzilla/bugzilla.git:
  git.latest:
    - rev: release-5.0-stable
    - branch: release-5.0-stable
    - target: /srv/http/bugzilla
    - require:
      - pkg: git
