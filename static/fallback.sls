https://github.com/strugee/null.strugee.net.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/fallback
    - require:
      - pkg: git
