# mopidy-repo:
#   pkgrepo.managed:
#     - name: |
#       # Mopidy APT archive
#       # Built on Debian 11 (bullseye), compatible with Ubuntu 22.04 LTS and newer
#       deb [signed-by=/etc/apt/keyrings/mopidy-archive-keyring.gpg] https://apt.mopidy.com/ bullseye main contrib non-free
#       deb-src [signed-by=/etc/apt/keyrings/mopidy-archive-keyring.gpg] https://apt.mopidy.com/ bullseye main contrib non-free
#     - file: /etc/apt/sources.list.d/mopidy.list
#     - key_url: salt://mopidy/mopidy.gpg
#     - require_in:
#       - pkg: mopidy

mopidy:
  pkg.installed: []
  service.running:
    - enable: True
    - require:
      - pkg: mopidy

# TODO apt-mark auto

mopidy-scrobbler:
  pkg.installed

Mopidy-Jellyfin:
  pip.installed:
    - require:
      - pkg: python3-pip

python3-pip:
  pkg.installed

Mopidy-YTMusic:
  pip.installed:
    - require:
      - pkg: python3-pip
