# TODO LXD proxy0 device

{% set version = '1.21.11' %}
{% set paperversion = '99' %}

/opt/spigot:
  file.directory

/opt/spigot/paper-{{ version }}-{{ paperversion }}.jar:
  file.managed:
    - source: https://api.papermc.io/v2/projects/paper/versions/{{ version }}/builds/{{ paperversion}}/downloads/paper-{{ version }}-{{ paperversion }}.jar
    - source_hash: sha512=df7b0e61b2863c31b9291d88e4d5d7684ebe3c51e65b08ed10a0ae0c0eeafa82de099d398ff1bea8af359d3c94e665f29f6fdfdcb16185c48d5f952477c6247a
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
