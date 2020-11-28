/etc/systemd/system.conf:
  file.replace:
    - pattern: '#RuntimeWatchdogSec=0'
    - repl: 'RuntimeWatchdogSec=30'
