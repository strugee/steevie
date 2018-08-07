# TODO use a separate machine running borg-serve and an append-only repo

# TODO cronjob

include: borgbackup.gdrive-fuse

# TODO this is installed from backports in prod
borgbackup:
  pkg.installed
