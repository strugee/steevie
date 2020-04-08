sensu-repo:
  pkgrepo.managed:
    - name: "deb https://packagecloud.io/sensu/stable/debian/ buster main"
    - file: /etc/apt/sources.list.d/sensu_stable.list
    - key_url: salt://sensu/sensu.asc
    - require_in:
      - pkg: sensu-go-backend

sensu-go-backend:
  pkg.installed:
    - refresh: True
