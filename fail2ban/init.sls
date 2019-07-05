fail2ban:
  pkg.installed: []
  service.running:
    - require:
      - pkg: fail2ban
