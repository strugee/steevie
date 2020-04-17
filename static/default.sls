{% macro subclone(method, name, ref) %}
https://github.com/strugee/{{ name }}.git:
  git.{{ method }}:
    {% if method == 'latest' %}
    - rev: {{ ref }}
    {% else %}
    - ref: {{ ref }}
    {% endif %}
    - branch: {{ ref }}
    - target: /srv/http/default/{{ name }}
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git
{% endmacro %}

https://github.com/strugee/strugee.github.com.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/default
    - require:
      - pkg: git

{% for name in ['dichotomous-key', 'fractured-reality', 'tidal-waves'] %}
{{ subclone('latest', name, 'gh-pages') }}
{% endfor %}

{{ subclone('latest', 'boeing-pollution', 'master') }}

{% for name in ['cryptography-basics', 'foss-intro', 'https-deployment', 'just-do-it', 'operational-security', 'publishing', 'security-design', 'straticjs', 'webapp-performance', 'webapp-security'] %}
{{ subclone('latest', 'presentation-' + name, 'gh-pages') }}
{% endfor %}

# XXX TODO: figure out what three/ should be

{% for data in [['original', '2014-build'], ['redux', '2015-june-build']] %}
cryptoparty-{{ data[0] }}:
  git.detached:
    - name: https://github.com/strugee/cryptoparty-seattle.git
    - rev: {{ data[1] }}
    - target: /srv/http/default/cryptoparty/{{ data[0] }}
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git
{% endfor %}

pumpio-lfnw:
  git.detached:
    - name: https://github.com/strugee/presentation-pumpio.git
    - rev: lfnw-2016-build
    - target: /srv/http/default/presentation-pumpio
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git

# XXX TODO: figure out TA3M version?

pumpio-libreplanet:
  git.latest:
    - name: https://github.com/strugee/presentation-pumpio.git
    - rev: gh-pages
    - branch: gh-pages
    - target: /srv/http/default/presentation-pumpio/libreplanet
    - require:
      - pkg: git
      - pumpio-lfnw
