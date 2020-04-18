python3-pip:
  pkg.installed

libfuse2:
  pkg.installed

# TODO make this use pip3???
gdrivefs:
  pip.installed:
    - name: 'git+https://github.com/dsoprea/GDriveFS@c504de1ef81d336946f249fb3b2cea3d5b2834c7'
    - require:
      - pkg: python3-pip

# TODO auth setup
