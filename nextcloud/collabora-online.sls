# LXD containers are... minimal. *Super* minimal.
include:
  - misc.gpg
  - apt

collabora-online-repo:
  pkgrepo.managed:
    - name: "deb https://www.collaboraoffice.com/repos/CollaboraOnline/CODE-debian9 ./"
    - file: /etc/apt/sources.list.d/collabora-online.list
    - keyid: 6CCEA47B2281732DF5D504D00C54D189F4BA284D
    - keyserver: hkps://keyserver.ubuntu.com
    - requires:
      - pkg: gnupg
    - require_in:
      - pkg: code-brand

code-brand:
  pkg.installed:
    - refresh: True

loolwsd:
  pkg.installed:
    - refresh: True

/etc/loolwsd/loolwsd.xml:
  file.managed:
    - owner: lool
    - group: lool
    - mode: 640
    - source: salt://nextcloud/loolwsd.xml
