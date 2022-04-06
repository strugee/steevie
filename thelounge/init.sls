{% set version = '4.3.0' %}
{% set debhash = 'fd2ad9a5b0f0f54bfc85163b13968d5856c82ace0d26843f41997f4cb90ce7bf8eb6ced00277cc87a306216901c7a6b6b23eaf093ade100e263719c16e331ca2' %}

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
