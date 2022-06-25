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

# TODO verify that this JAR corresponds to the source I audited at 88eaacd0c1812e2845e2243cddff74efb548106a
# TODO restart spigot after? Idk
/opt/spigot/plugins/prometheus-exporter.jar:
  file.managed:
    - source: https://github.com/sladkoff/minecraft-prometheus-exporter/releases/download/v2.4.0/minecraft-prometheus-exporter-2.4.0.jar
    - source_hash: sha512=e84d09eb04ab63635f2fe23134f968c5fc10a20f8fc3f53ebe5c46fd51dbe928c639008818ce9b737c0a32e50452964ad6ae0824e126b995eb3e0c7372f27443
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
