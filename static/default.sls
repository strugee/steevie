https://github.com/strugee/strugee.github.com.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/default
    - require:
      - pkg: git
