apache2:
  pkg.installed: []
# TODO
#    - require:
#      - file: /etc/apache2
  service.running:
    - require:
      - pkg: apache2

/etc/apache2:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - keep_symlinks: True
    - source: salt://httpd/apache2/
