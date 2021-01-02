librephotos:
  group.present:
    - system: True
  user.present:
    - fullname: LibrePhotos
    - gid_from_name: True
    - home: /srv/http/librephotos
    - createhome: False
    - shell: /bin/false
    - system: True
    - require:
      - group: librephotos

# Used to run Pip - setup.py is arbitrary code so can't run this unsandboxed/as root
librephotosinstall:
  group.present:
    - system: True
  user.present:
    - fullname: LibrePhotos Python install user
    - gid_from_name: True
    - home: /srv/http/librephotos
    - createhome: False
    - shell: /bin/false
    - system: True
    - require:
      - group: librephotosinstall

/usr/local/src/equivs/librephotos:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://librephotos/librephotos.equivs

librephotos-equivs:
  cmd.run:
    - name: equivs-build /usr/local/src/equivs/librephotos
    - cwd: /usr/local/src/equivs/
    - creates: /usr/local/src/equivs/librephotos_1.0_all.deb
    - require:
      - file: /usr/local/src/equivs/librephotos
#      - pkg: equivs

/usr/local/src/equivs/librephotos_1.0_all.deb:
  pkg.installed:
    - onchanges:
      - cmd: librephotos-equivs

# TODO create Postgres role and db

##################################
# Backend

librephotos-clone:
  git.detached:
    - name: https://github.com/LibrePhotos/librephotos.git
    - rev: 7f3d17538e03d022aceb18143f22acb95c2239ca
    - target: /srv/http/librephotos
#    - require:
#      - pkg: git

librephotos-perms-fixup:
  cmd.run:
    - name: 'chown -R librephotosinstall:librephotosinstall .'
    - cwd: /srv/http/librephotos
    - onchanges:
      - git: librephotos-clone
    - require:
      - user: librephotosinstall
      - git: librephotos-clone

/srv/http/librephotos:
  virtualenv.managed:
    - requirements: /srv/http/librephotos/requirements.txt
    - pip_pkgs:
      # TODO should these be in upstream requirements.txt?
      - psycopg2
      - sklearn
      - torch
      - torchvision
    - user: librephotosinstall
    - python: python3
    - require:
      # TODO require the equivs dummy package to be installed
      - git: librephotos-frontend-clone
      - user: librephotosinstall

##################################
# Models and such

librephotos-spacy-install:
  cmd.run:
    - name: '. bin/activate && python3 -m spacy download en_core_web_sm'
    - runas: librephotosinstall
    - creates: /srv/http/librephotos/lib/python3.7/site-packages/en_core_web_sm
    - require:
      - virtualenv: /srv/http/librephotos

/srv/http/librephotos/api/places365:
  archive.extracted:
    - source: https://s3.eu-central-1.amazonaws.com/ownphotos-deploy/places365_model.tar.gz
    # TODO verify this hash from a geographically disparate location
    - source_hash: sha512=08018919941c9d9eccb25f179f421001b571498454220397dc833a55d90c2eff374a4f173ce09bc1aea11482740e4d3eba7484c3860f8b06613c1a61fb8ff016
    - user: librephotosinstall
    - group: librephotosinstall
    - requires:
      - git: lbirephotos-clone

/srv/http/librephotos/api/im2txt:
  archive.extracted:
    - source: https://s3.eu-central-1.amazonaws.com/ownphotos-deploy/im2txt_model.tar.gz
    # TODO verify this hash from a geographically disparate location
    - source_hash: sha512=8e61a1338c02cdbeeecf3dafbc65b9598986e3fb24f45cb21d199584255e80d28f0b38d018d5868649aff1501361f6930c1555812bd80dad251001ecb3871c93
    - user: librephotosinstall
    - group: librephotosinstall
    - requires:
      - git: lbirephotos-clone

im2txt-data:
  archive.extracted:
    - name: /srv/http/librephotos/api/im2txt
    - source: https://s3.eu-central-1.amazonaws.com/ownphotos-deploy/im2txt_data.tar.gz
    # TODO verify this hash from a geographically disparate location
    - source_hash: sha512=b0098abe436eda26ab5926bc5dd17e5506531d06ac196c3a0a7630dc33d3134b72dc8cc624eae3c110ebe642ed69c64395cbd0e863d2d031c0bf33f9447143cd
    - user: librephotosinstall
    - group: librephotosinstall
    - requires:
      - git: librephotos-clone

##################################
# Backend config resources

/srv/http/librephotos/photos:
  file.directory:
    - require:
      - git: librephotos-clone

# TODO this overwrites stuff in git; is this going to blow up when we change the pinned deploy commit?
/srv/http/librephotos/config.py:
  file.managed:
    - source: salt://librephotos/config.py
    - user: librephotosinstall
    - group: librephotos
    - mode: 640
    - template: jinja
    - require:
      - git: librephotos-clone

/etc/librephotos.env:
  file.managed:
    - source: salt://librephotos/librephotos.env
    - user: librephotosinstall
    - group: librephotos
    - mode: 640
    - template: jinja
    - require:
      - user: librephotosinstall

##################################
# Frontend

librephotos-frontend-clone:
  git.detached:
    - name: https://github.com/LibrePhotos/librephotos-frontend.git
    - rev: ddc4e2dabb0c78c5395df954a5851019a5dc6ecb
    - target: /srv/http/librephotos-frontend
#    - require:
#      - pkg: git

librephotos-frontend-npm:
  cmd.run:
    - name: 'npm install'
    - cwd: /srv/http/librephotos-frontend
    - onchanges:
      - git: librephotos-frontend-clone
    - require:
      # TODO require the equivs dummy package to be installed
      - git: librephotos-frontend-clone


##################################
# Runtime and integration

/var/cache/librephotos:
  file.directory:
    - user: librephotos
    - group: librephotos
    - mode: 700

/var/lib/local/librephotos:
  file.directory:
    - user: librephotos
    - group: librephotos
    - mode: 700

/srv/http/librephotos/logs:
  file.symlink:
    - target: /var/log/librephotos
    - require:
      - git: librephotos-clone

/var/log/librephotos:
  file.directory:
    - user: librephotos
    - group: librephotos
    - recurse:
      - user
      - group
      - mode
    - file_mode: 660
    - dir_mode: 770
    - require:
      - group: librephotos

/usr/local/bin/librephotosctl:
  file.managed:
    - mode: 755
    - user: root
    - group: root
    - contents: |
        #!/bin/sh
        
        # If we are not running as the librephotos user, reexecute as that user
        [ $(whoami) != librephotos ] && exec sudo -u librephotos "$0" "$@"
        
        cd /srv/http/librephotos
        . bin/activate
        
        # Load environment configuration, stripping comments and empty lines
        eval $(grep -ve '^#' -e '^$' /etc/librephotos.env | sed 's/^/export /')
        
        python3 manage.py "$@"

/etc/redis/redis-librephotos.conf:
  file.managed:
    - source: salt://librephotos/redis-librephotos.conf
    - user: redis
    - group: redis
    - mode: 640

# TODO onchanges systemctl daemon-reload
/etc/systemd/system/redis-server@librephotos.service.d/override.conf:
  file.managed:
    - source: salt://librephotos/redis-systemd-override.conf

redis-server@librephotos:
  service.running:
    - enable: True
    - require:
      - file: /etc/redis/redis-librephotos.conf
      - file: /etc/systemd/system/redis-server@librephotos.service.d/override.conf

# TODO onchanges systemctl daemon-reload
/etc/systemd/system/librephotos-rq.service:
  file.managed:
    - source: salt://librephotos/librephotos-rq.service

librephotos-rq:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/librephotos-rq.service

/etc/uwsgi/apps-available/librephotos.ini:
  file.managed:
    - source: salt://librephotos/uwsgi.ini

# TODO onchanges systemctl daemon-reload
/etc/systemd/system/librephotos-uwsgi.service:
  file.managed:
    - source: salt://librephotos/librephotos-uwsgi.service

librephotos-uwsgi:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/librephotos-uwsgi.service
      - file: /etc/uwsgi/apps-available/librephotos.ini

# TODO start the uWSGI app

# TODO run migrations
# TODO run image_similarity/main.py
# TODO run build_similarity_index, or maybe do that every service start? Needs investigation
