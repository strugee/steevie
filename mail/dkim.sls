# TODO actually create the key

/var/lib/rspamd/dkim:
  file.directory:
    # TODO these apparently aren't needed in prod??
    #- user: _rspamd
    #- group: _rspamd
    - require:
      - pkg: rspamd
