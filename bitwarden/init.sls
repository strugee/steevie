# TODO create LXD container

# TODO: sudo lxc config device add bitwarden proxy3 proxy listen=tcp:216.160.72.226:443 connect=tcp:127.0.0.1:443

/root/bitwarden.sh:
  file.managed:
    - source: salt:///bitwarden/bitwarden.sh
    - mode: 755

# TODO run ./bitwarden install (note: it's interactive??)

# TODO provision config files with secrets
