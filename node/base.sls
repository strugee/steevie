nodesource-repo:
  pkgrepo.managed:
    - name: "deb https://deb.nodesource.com/node_10.x stretch main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      - pkg: apt-transport-https
      - pkg: gnupg
    - require_in:
      - pkg: nodejs

nodesource-repo-src:
  pkgrepo.managed:
    - name: "deb-src https://deb.nodesource.com/node_10.x stretch main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      - pkgrepo: nodesource-repo
      - pkg: apt-transport-https
    - require_in:
      - pkg: nodejs

nodejs:
  pkg.installed
