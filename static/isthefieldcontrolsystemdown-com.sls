https://github.com/strugee/isthefieldcontrolsystemdown.com.git:
  git.latest:
    - rev: master
    - branch: master
    - target: /srv/http/isthefieldcontrolsystemdown.com
    - require:
      - pkg: git
