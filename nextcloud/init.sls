/usr/local/src/equivs:
  file.directory

/usr/local/src/equivs/nextcloud:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://nextcloud/nextcloud.equivs

nextcloud-equivs:
  cmd.run:
    - name: equivs-build /usr/local/src/equivs/nextcloud
    - cwd: /usr/local/src/equivs/
    - creates: /usr/local/src/equivs/nextcloud_1.0_all.deb
    - require:
      - file: /usr/local/src/equivs/nextcloud
#      - pkg: equivs

/usr/local/src/equivs/nextcloud_1.0_all.deb:
  pkg.installed:
    - onchanges:
      - cmd: nextcloud-equivs

# TODO base install

# TODO multibyte database

# TODO innodb_large_prefix=on
# TODO innodb_file_format=Barracuda
# Run occ maintenance:repair after these too.
