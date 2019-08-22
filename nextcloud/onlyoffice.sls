# LXD containers are... minimal. *Super* minimal.
include:
  - apt.backports
  - apt

# TODO db password
onlyoffice-debconf:
  debconf.set:
    - name: onlyoffice-documentserver
    - data:
        onlyoffice/db-host: {'type': 'string', 'value': 'host.lxd'}
        onlyoffice/db-user: {'type': 'string', 'value': 'onlyoffice'}
        onlyoffice/db-name: {'type': 'string', 'value': 'onlyoffice'}
        onlyoffice/redis-host: {'type': 'string', 'value': 'host.lxd'}

onlyoffice-repo:
  pkgrepo.managed:
    - name: "deb http://download.onlyoffice.com/repo/debian squeeze main"
    - file: /etc/apt/sources.list.d/onlyoffice.list
    - keyid: E09CA29F6E178040EF22B4098320CA65CB2DE8E5
    - keyserver: hkps://keyserver.ubuntu.com
    - requires:
      - pkg: gnupg
    - require_in:
      - pkg: onlyoffice-documentserver

mono-repo:
  pkgrepo.managed:
    - name: "deb https://download.mono-project.com/repo/debian stable-stretch main"
    - file: /etc/apt/sources.list.d/mono-official-stable.list
    - keyid: 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
    - keyserver: hkps://keyserver.ubuntu.com
    - requires:
      - pkg: gnupg
      - pkg: apt-transport-https
    - require_in:
      - pkg: onlyoffice-documentserver

rabbitmq-server:
  pkg.installed

onlyoffice-documentserver:
  pkg.installed:
    - refresh: True

# TODO install nodejs, npm from backports
nodejs:
  pkg.installed

npm:
  pkg.installed
