# TODO LXD proxy0 device

/opt/spigot:
  file.directory

/opt/spigot/BuildTools.jar:
  file.managed:
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/108/artifact/target/BuildTools.jar
    - source_hash: sha512=9982554fbdadf8dab00c7cdafe312d124d0be1ffdc56b56fcc450e2bbecd5e863cadeb48f4f9add01b24e27a58693c2bca5015a285044579fc5f22883047a9d9
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
