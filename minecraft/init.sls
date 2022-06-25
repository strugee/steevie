# TODO LXD proxy0 device

{% set version = '1.19' %}
{% set paperversion = '36' %}

/opt/spigot:
  file.directory

/opt/spigot/paper-{{ version }}-{{ paperversion }}.jar:
  file.managed:
    - source: https://papermc.io/api/v2/projects/paper/versions/{{ version }}/builds/{{ paperversion}}/downloads/paper-{{ version }}-{{ paperversion }}.jar
    - source_hash: sha512=48d8dcb85d55731c273f64a8f75b85a11ad8e625a9cb3558822f1fc659f98024b2465e69120a2909a45f3f09f80bda5c57d021d39a01359ae16963f18048c40b
    - require:
      - file: /opt/spigot

/opt/spigot/eula.txt:
  file.managed:
    - source: salt:///minecraft/eula.txt
    - require:
      - file: /opt/spigot

# TODO restart server onchanges
/opt/spigot/paper.yml:
  file.managed:
    - source: salt:///minecraft/paper.yml
    - require:
      - file: /opt/spigot

# TODO restart spigot after? Idk
/opt/spigot/plugins/SpigotSystemd.jar:
  file.managed:
    - source: https://git.revreso.de/gigadoc2/spigot-systemd/uploads/a172b6c0460eba7b6fdfaabe54490d59/SpigotSystemd.jar
    - source_hash: sha512=dd729e09e4ab01326eff096aa2c6718695d675507d9078271ac7966f73c37fcb09ba216540176e1968169d79c824365f79f316a48e5b132afa4808d04fba97ab
    - make_dirs: True
    - require:
      - file: /opt/spigot

# TODO audit source for this upgraded version
# TODO restart spigot after? Idk
/opt/spigot/plugins/prometheus-exporter.jar:
  file.managed:
    - source: https://github.com/sladkoff/minecraft-prometheus-exporter/releases/download/v2.5.0/minecraft-prometheus-exporter-2.5.0.jar
    - source_hash: sha512=131aa90ed7c8437e8ff87fa4b10e5c17313a6b851814df2cdcde1d0fb5948e3b468d25d3073b96914febcf836abcd54caec71845db5b702ff640bc9354381d8a
    - make_dirs: True
    - require:
      - file: /opt/spigot

/opt/spigot/plugins/PrometheusExporter/config.yml:
  file.managed:
    - source: salt:///minecraft/prometheus-config.yml
    - make_dirs: True
    - require:
      - file: /opt/spigot

#/opt/spigot/server.properties:
#  file.managed:
#    - source: salt:///minecraft/server.properties
#    - require:
#      - file: /opt/spigot

/etc/systemd/system/minecraft-server.service:
  file.managed:
    - source: salt:///minecraft/minecraft-server.service
    - template: jinja
    - defaults:
      version: {{ version }}
      paperversion: {{ paperversion }}

minecraft-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/minecraft-server.service

minecraft-server:
  service.enabled:
    - require:
      - file: /etc/systemd/system/minecraft-server.service
