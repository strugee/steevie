elasticsearch-repo:
  pkgrepo.managed:
    - name: "deb https://artifacts.elastic.co/packages/6.x/apt stable main"
    - file: /etc/apt/sources.list.d/elastic-6.x.list
    - key_url: salt://nextcloud/elasticsearch-key.asc
    - require_in:
      - pkg: elasticsearch

elasticsearch:
  pkg.installed:
    - refresh: True
    - require:
      - pkg: default-jre-headless
