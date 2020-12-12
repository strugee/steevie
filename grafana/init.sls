grafana-repo:
  pkgrepo.managed:
    - name: "deb https://packages.grafana.com/oss/deb stable main"
    - file: /etc/apt/sources.list.d/grafana.list
    - key_url: salt://grafana/repo_key.asc
    - require_in:
      - pkg: grafana

grafana:
  pkg.installed:
    - refresh: True

grafana-server:
  service.running:
    - enable: True
    - require:
      - pkg: grafana
