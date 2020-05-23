# This exists because I often reflexively prefix commands with `sudo` in LXD containers, which do not have sudo installed.
# This script just executes its arguments unchanged.

/usr/local/bin/sudo:
  file.managed:
    - mode: 755
    - user: root
    - group: root
    - contents: |
        exec $@
        #!/bin/sh
