{% set version = '4.1.0' %}
{% set debhash = 'fa0bd63923c88cce10c4edab531389c5e2d1a6a3cf98ff765791dd8be410dcdb0d482bca59955b10895201385663e0d4946bb2732c7dee5f000b80b67b8d2ffc' %}

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
