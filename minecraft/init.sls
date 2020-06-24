# TODO LXD proxy0 device

/opt/spigot:
  file.directory

/opt/spigot/BuildTools.jar:
  file.managed:
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/115/artifact/target/BuildTools.jar
    - source_hash: sha512=056455c52313b10c0e662cfffc193c53fc10bc35d9a78ace59496ec1cf728f86632891e0337b3572e4e206013d43eb535a3a9d8b7ff95530d1e1ed2e7ac58dfe
    - require:
      - file: /opt/spigot

# TODO should we make this require git? It's pulled in by etckeeper and it's annoying to put here
'java -jar BuildTools.jar --rev 1.15.2':
  cmd.run:
    - cwd: /opt/spigot
    - creates: /opt/spigot/spigot-1.15.2.jar
    - require:
      - pkg: default-jre-headless
    - env:
      - HOME: /opt/spigot

/opt/spigot/eula.txt:
  file.managed:
    - source: salt:///minecraft/eula.txt
    - require:
      - file: /opt/spigot

/opt/spigot/server.properties:
  file.managed:
    - source: salt:///minecraft/server.properties
    - require:
      - file: /opt/spigot

/etc/systemd/system/minecraft-server.service:
  file.managed:
    - source: salt:///minecraft/minecraft-server.service

minecraft-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/minecraft-server.service

minecraft-server:
  service.enabled:
    - require:
      - file: /etc/systemd/system/minecraft-server.service
