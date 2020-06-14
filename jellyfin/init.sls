jellyfin-repo:
  pkgrepo.managed:
    - name: "deb [arch=amd64] https://repo.jellyfin.org/debian buster main"
    - file: /etc/apt/sources.list.d/jellyfin.list
    - key_url: salt://jellyfin/jellyfin_team.gpg.key
    - require_in:
      - pkg: jellyfin

jellyfin:
  pkg.installed:
    - refresh: True
  service.running:
    - enable: True
    - require:
      - pkg: jellyfin

