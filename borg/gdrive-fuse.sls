# TODO config file in /root
# TODO move config to /etc
# TODO fstab entry
# TODO Google API keys?

gdrive-fuse-repo:
  pkgrepo.managed:
    - name: "deb http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu xenial main"
    - file: /etc/apt/sources.list.d/alessandro-strada-ppa.list
    - keyid: 9EA4D6FCA5D37A5D1CA9C09AAD5F235DF639B041
    - keyserver: hkps://keyserver.ubuntu.com
    - require_in:
      - pkg: google-drive-ocamlfuse

gdrive-fuse-repo-src:
  pkgrepo.managed:
    - name: "deb-src http://ppa.launchpad.net/alessandro-strada/ppa/ubuntu xenial main"
    - file: /etc/apt/sources.list.d/alessandro-strada-ppa.list
    - require:
      - gdrive-fuse-repo

google-drive-ocamlfuse:
  pkg.installed:
    - refresh: True

fuse:
  pkg.installed
