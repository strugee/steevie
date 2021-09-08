nodesource-repo:
  pkgrepo.managed:
    - name: "deb https://deb.nodesource.com/node_10.x {{ grains['oscodename'] }} main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      {% if grains['osmajorrelease'] == 9 %}
      - pkg: apt-transport-https
      {% endif %}
      - pkg: gnupg
    - require_in:
      - pkg: nodejs

nodesource-repo-src:
  pkgrepo.managed:
    - name: "deb-src https://deb.nodesource.com/node_10.x {{ grains['oscodename'] }} main"
    - file: /etc/apt/sources.list.d/nodesource.list
    - key_url: salt://node/nodesource.key
    - require:
      - pkgrepo: nodesource-repo
      {% if grains['osmajorrelease'] == 9 %}
      - pkg: apt-transport-https
      {% endif %}
    - require_in:
      - pkg: nodejs

nodejs:
  pkg.installed
