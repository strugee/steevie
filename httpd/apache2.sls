apache2:
  pkg.installed: []
# TODO
#    - require:
#      - file: /etc/apache2
  service.running:
    - require:
      - pkg: apache2

# TODO I had to manually patch this
libapache2-mod-authn-yubikey:
  pkg.installed: []

/etc/apache2:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - keep_symlinks: True
    - source: salt://httpd/apache2/
