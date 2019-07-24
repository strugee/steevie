# TODO LXD proxy0 device

/opt/spigot:
  file.directory

/opt/spigot/BuildTools.jar:
  file.managed:
    - source: https://hub.spigotmc.org/jenkins/job/BuildTools/101/artifact/target/BuildTools.jar
    - source_hash: sha512=dc68f0346f1478d5a0e08efcc54b04b613a06cf41359d2779c6adb0985e59ad143cce2cd468c73845cc07437080cf9796436d1ca41124027299990c88d0d28b9
    - require:
      - file: /opt/spigot

# TODO should we make this require git? It's pulled in by etckeeper and it's annoying to put here
'java -jar BuildTools.jar --rev 1.14.4':
  cmd.run:
    - cwd: /opt/spigot
    - creates: /opt/spigot/spigot-1.14.4.jar
    - require:
      - pkg: default-jre-headless

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
