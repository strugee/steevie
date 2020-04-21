# WARNING! This is not (yet) the canonical location for Apache configs!
# You will want to run apache-config.pp after executing this state!
# When it *does* become canonical, this should move into apache2.sls. The only reason it's not there now is so it doesn't get pulled into state executions.

/etc/apache2:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - keep_symlinks: True
    - source: salt://httpd/apache2/

