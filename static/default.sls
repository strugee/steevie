https://github.com/strugee/strugee.github.com.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/default
    - require:
      - pkg: git

{% for name in ['dichotomous-key', 'fractured-reality', 'tidal-waves'] %}
https://github.com/strugee/{{ name }}.git:
  git.latest:
    - rev: gh-pages
    - branch: gh-pages
    - target: /srv/http/default/{{ name }}
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git
{% endfor %}

https://github.com/strugee/boeing-pollution.git:
  git.latest:
    - rev: master
    - branch: masters
    - target: /srv/http/default/boeing-pollution
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git

{% for name in ['cryptography-basics', 'foss-intro', 'https-deployment', 'just-do-it', 'operational-security', 'publishing', 'security-design', 'straticjs', 'webapp-performance', 'webapp-security'] %}
https://github.com/strugee/presentation-{{ name }}.git:
  git.latest:
    - rev: gh-pages
    - branch: gh-pages
    - target: /srv/http/default/presentation-{{ name }}
    - require:
      - pkg: git
      - https://github.com/strugee/strugee.github.com.git
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
    - rev: lfnw-2016-build
    - target: /srv/http/default/presentation-pumpio/libreplanet
    - require:
      - pkg: git
      - pumpio-lfnw
