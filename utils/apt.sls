aptitude:
  pkg.installed

apt-file update:
  cmd.run:
    - onchanges:
      - pkg: apt-file
    - require:
      - pkg: apt-file

apt-file:
  pkg.installed
