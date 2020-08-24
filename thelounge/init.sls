{% set version = '4.2.0' %}
{% set debhash = '10d17c199fef595c46ba55f36ab7aa0a7469448603482eb780284e05532f5d69302d47bdc9c558badc30b0a026767a24b7065a4fe8d7c865f1737b0041420208' %}

/usr/local/src/thelounge/thelounge_{{ version }}_all.deb:
  file.managed:
    - source: https://github.com/thelounge/thelounge/releases/download/v{{ version }}/thelounge_{{ version }}_all.deb
    - source_hash: sha512={{ debhash }}
    - makedirs: True
  pkg.installed:
    - require:
      - file: /usr/local/src/thelounge/thelounge_{{ version }}_all.deb

/etc/thelounge/config.js:
  file.managed:
    - source: salt://thelounge/config.js

{% for themename in ['solarized', 'crypto', 'classic', 'zenburn'] %}
'/usr/bin/sudo -u thelounge thelounge install thelounge-theme-{{ themename }}':
  cmd.run:
    - creates: /etc/thelounge/packages/node_modules/thelounge-theme-{{ themename }}
    - require:
      - pkg: /usr/local/src/thelounge/thelounge_{{ version }}_all.deb
{% endfor %}
