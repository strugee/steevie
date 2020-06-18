osquery-repo:
  pkgrepo.managed:
    - name: "deb [arch=amd64] https://pkg.osquery.io/deb deb main"
    - file: /etc/apt/sources.list.d/osquery.list
    - keyid: 1484120AC4E9F8A1A577AEEE97A80C63C9D8B80B
    - keyserver: hkps://keyserver.ubuntu.com
    - require_in:
      - pkg: osquery

osquery:
  pkg.installed
