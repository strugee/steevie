npm:
  npm.installed:
    - require:
      # XXX this is here because NodeSource pulls in npm, fulfilling this requirement, but I'm not sure that's the right way to do it
      - pkg: nodejs
