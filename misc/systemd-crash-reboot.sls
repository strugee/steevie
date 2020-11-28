/etc/systemd/system.conf:
  file.replace:
    - pattern: '#CrashReboot=no'
    - repl: 'CrashReboot=yes'
