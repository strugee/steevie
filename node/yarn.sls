yarnpkg:
  pkg.installed

/etc/profile.d/yarn-nodepath.sh:
  file.managed:
    - mode: 755
    - contents: |
        #!/bin/sh
        
        # See debbugs #933229
        export NODE_PATH=/usr/lib/nodejs:/usr/share/nodejs
