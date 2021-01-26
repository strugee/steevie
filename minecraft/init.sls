# TODO LXD proxy0 device

{% set version = '1.16.4' %}

/opt/spigot:
  file.directory

/opt/spigot/BuildTools.jar:
  file.managed:
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/122/artifact/target/BuildTools.jar
    - source_hash: sha512=d0512817037fd5d29c564aacde6d7a5bd477641bbddbe4a90734c0501c0f55e88b46882e5a520cc52c18812c89775732788bb193995a8497c50063a81fa5b355
    - require:
      - file: /opt/spigot

# TODO should we make this require git? It's pulled in by etckeeper and it's annoying to put here
'java -jar BuildTools.jar --rev {{ version }}':
  cmd.run:
    - cwd: /opt/spigot
    - creates: /opt/spigot/spigot-{{ version }}.jar
    - require:
      - file: /opt/spigot/BuildTools.jar
      - pkg: default-jre-headless
    - env:
      - HOME: /opt/spigot

/opt/spigot/eula.txt:
  file.managed:
    - source: salt:///minecraft/eula.txt
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

minecraft-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/minecraft-server.service

minecraft-server:
  service.enabled:
    - require:
      - file: /etc/systemd/system/minecraft-server.service
