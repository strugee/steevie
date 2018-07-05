https://github.com/strugee/nodecompat.com.git:
  git.latest:
    - rev: gh-pages
    - branch: gh-pages
    - target: /srv/http/nodecompat.com
    - require:
      - pkg: git
