uwsgi-plugin-python:
  pkg.installed

/etc/uwsgi/apps-available/mediagoblin.ini:
  file.managed:
    - source: salt://mediagoblin/uwsgi.ini

# TODO onchanges systemctl daemon-reload
/etc/systemd/system/mediagoblin-uwsgi.service:
  file.managed:
    - source: salt://mediagoblin/mediagoblin-uwsgi.service

mediagoblin-uwsgi:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/mediagoblin-uwsgi.service
      - file: /etc/uwsgi/apps-available/mediagoblin.ini

# TODO start the uWSGI app

# TODO like... everything

# TODO add www-data to the mediagoblin group so it can write to the uWSGI Unix domain socket
