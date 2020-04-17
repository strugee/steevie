# TODO LXD proxy0 device

/opt/spigot:
  file.directory

/opt/spigot/BuildTools.jar:
  file.managed:
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/112/artifact/target/BuildTools.jar
    - source_hash: sha512=20b5e905f7978f488bd5a4cf3cbfa497bd3307f5176cb6776ed382d45ed3c53a803c368299c465ac46ab855167fd3ca0a779fc6646db8dc6a751e5b37bc5b6b8
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
