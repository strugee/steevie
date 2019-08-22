# TODO use a separate machine running borg-serve and an append-only repo

# TODO cronjob

include:
  - borg.gdrive-fuse

# TODO this is installed from backports in prod
borgbackup:
  pkg.installed

# Needed for the /usr/local/bin/run-borg script
liblockfile-bin:
  pkg.installed

/etc/apt/apt.conf.d/00borg-system-trigger:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://borg/00borg-system-trigger
