tarsnap-repo:
  pkgrepo.managed:
    - name: "deb http://pkg.tarsnap.com/deb/stretch ./"
    - file: /etc/apt/sources.list.d/tarsnap.list
    # XXX: is this key going to change every year?
    - key_url: salt://tarsnap/tarsnap-deb.asc
    - require_in:
      - pkg: tarsnap

tarsnap:
  pkg.installed:
    - refresh: True
