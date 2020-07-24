ffmpeg:
  pkg.installed

peertube:
  group.present:
    - system: True
  user.present:
    - fullname: PeerTube
    - gid_from_name: True
    - home: /srv/http/peertube
    # TODO maybe change this (upstream told me to)
    - shell: /bin/bash
    - system: True
    - require:
      - group: peertube
  service.running:
    - enable: True
    - watch:
      - file: /etc/systemd/system/peertube.service
      - file: /etc/peertube/production.yml
      {% for i in ['', 'avatars', 'videos', 'streaming-playlists', 'redundancy', 'previews', 'thumbnails', 'torrents', 'captions', 'plugins'] %}
      - file: /var/lib/local/peertube/{{ i }}
      {% endfor %}
      - file: /var/cache/peertube
      - file: /var/log/peertube
      - file: /etc/peertube/client-overrides
      # TODO postgres db provision
      - cmd: peertube-yarn
      - cmd: peertube-tmpfiles
      - pkg: ffmpeg
      #- pkg: nodejs

# TODO Postgres user, db, enable extensions
# sudo -u postgres createuser -P peertube
# sudo -u postgres createdb -O peertube -E UTF8 -T template0 peertube_prod
# sudo -u postgres psql -c 'CREATE EXTENSION pg_trgm;' peertube_prod
# sudo -u postgres psql -c 'CREATE EXTENSION unaccent;' peertube_prod

peertube-source:
  archive.extracted:
    - name: /srv/http/peertube/
    # TODO make this use --transform to extract to /srv/http/ instead, so we can remove enforce_toplevel
    - options: '--strip-components=1'
    - enforce_toplevel: False
    - clean: True
    - source: https://github.com/Chocobozzz/PeerTube/releases/download/v2.3.0/peertube-v2.3.0.tar.xz
    - source_hash: 13e2fffeeafb13e90051cb274868786babea5d48fd2bd7a6d793a4ec62836b8cb09f830cf4e9c0ce2dcd999b7cadbf5f0239e9a603437bce07a5a6ae2de6ada5

# TODO run yarn install; depend on pkg: yarnpkg
peertube-yarn:
  cmd.run:
    # Need sudo -i so that /etc/profile.d/yarn-nodepath.sh gets run
    # TODO: figure out how to make this use the system Yarn cache
    - name: 'chown -R peertube:peertube . && sudo -iu peertube yarnpkg install --production --pure-lockfile && chown -R root:root .'
    - cwd: /srv/http/peertube
    - creates: node_modules
    - require:
      - archive: peertube-source

/etc/tmpfiles.d/peertube.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://peertube/tmpfiles.conf

peertube-tmpfiles:
  cmd.run:
    - name: 'systemd-tmpfiles --create'
    - onchanges:
      - file: /etc/tmpfiles.d/peertube.conf

/etc/sysctl.d/30-peertube-tcp.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://peertube/30-peertube-tcp.conf

peertube-sysctl:
  cmd.run:
    - name: 'sysctl -p /etc/sysctl.d/30-peertube-tcp.conf'
    - onchanges:
      - file: /etc/sysctl.d/30-peertube-tcp.conf

/etc/systemd/system/peertube.service:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://peertube/peertube.service

peertube-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/peertube.service

/etc/peertube/production.yml:
  file.managed:
    - user: root
    - group: peertube
    - mode: 640
    - template: jinja
    - makedirs: True
    - source: salt://peertube/production.yml

{% for i in ['', 'avatars', 'videos', 'streaming-playlists', 'redundancy', 'previews', 'thumbnails', 'torrents', 'captions', 'plugins'] %}
/var/lib/local/peertube/{{ i }}:
  file.directory:
    - user: peertube
    - group: peertube
    - mode: 700
    - makedirs: True
{% endfor %}

/var/log/peertube:
  file.directory:
    - user: peertube
    - group: peertube
    - mode: 700
    - makedirs: True

/var/cache/peertube:
  file.directory:
    - user: peertube
    - group: peertube
    - mode: 700
    - makedirs: True

/etc/peertube:
  file.directory:
    - user: root
    - group: peertube
    - mode: 775

/etc/peertube/client-overrides:
  file.directory:
    - user: root
    - group: root
    - makedirs: True
