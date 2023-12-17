grafana-repo:
  pkgrepo.managed:
    - name: "deb [signed-by=/etc/apt/keyrings/grafana.key] https://apt.grafana.com stable main"
    - file: /etc/apt/sources.list.d/grafana.list
    - require_in:
      - pkg: grafana
    - require:
      - file: /etc/apt/keyrings/grafana.key

/etc/apt/keyrings/grafana.key:
  file.managed:
    - source: salt://grafana/repo_key.asc
    - user: root
    - group: root
    - mode: 644

grafana:
  pkg.installed:
    - refresh: True

grafana-server:
  service.running:
    - enable: True
    - require:
      - pkg: grafana

# TODO `systemctl restart` after this changes
/etc/grafana/grafana.ini:
  file.managed:
    - source: salt:///grafana/grafana.ini
    - user: root
    - group: grafana
    - mode: 640
    - template: jinja
    - require:
      - pkg: grafana
