# TODO LXD proxy0 device

{% set version = '1.16.3' %}

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
