nodesource-repo:
  pkgrepo.managed:
    - name: "deb https://deb.nodesource.com/node_10.x stretch main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      - apt-transport-https
    - require_in:
      - pkg: nodejs

nodesource-repo-src:
  pkgrepo.managed:
    - name: "deb-src https://deb.nodesource.com/node_10.x stretch main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      - nodesource-repo
      - apt-transport-https
    - require_in:
      - pkg: nodejs

nodejs:
  pkg.installed

include:
  - node.npm
  - node.pumpio
  - node.offandonagain-org
  - node.fulldom
  - node.lazymention
  - node.gh-pages-server
  - node.pumabot
  - node.gradlebot
  - node.dev
