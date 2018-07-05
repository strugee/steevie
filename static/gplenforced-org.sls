https://github.com/strugee/gplenforced.org.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/gplenforced.org
    - require:
      - pkg: git
