# WARNING! This is not (yet) the canonical location for Apache configs!
# You will want to run apache-config.pp after executing this state!
# When it *does* become canonical, this should move into apache2.sls. The only reason it's not there now is so it doesn't get pulled into state executions.

# TODO remove replace: False below
# TODO make sure that these config files match steevie, which is authoritative

/etc/apache2:
  file.recurse:
    - owner: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - replace: False
    - source: salt://httpd/apache2/

