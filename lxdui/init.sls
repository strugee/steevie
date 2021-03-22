# TODO LXD Unix socket proxy device
# lxc config device add lxdui lxdsocket proxy connect=unix:/var/snap/lxd/common/lxd/unix.socket listen=unix:/var/lib/lxd/unix.socket bind=instance uid=0 gid=0 mode=0660

git:
  pkg.installed

libssl-dev:
  pkg.installed

python3:
  pkg.installed

python3-pip:
  pkg.installed

# TODO move this to /usr/local/src since setup.py copies instead of links these files
lxdui-clone:
  git.detached:
    - name: https://github.com/strugee/lxdui.git
    - rev: v2.1.3-strugeesecpatches
    - target: /opt/lxdui
    - require:
      - pkg: git

# TODO don't run this every time (because the git state changes)
'python3 setup.py install':
  cmd.run:
    - cwd: /opt/lxdui
    - onchanges:
      - git: lxdui-clone
    - require:
      - pkg: libssl-dev
      - pkg: python3
      - pkg: python3-pip
      - git: lxdui-clone

/etc/systemd/system/lxdui.service:
  file.copy:
    - source: /opt/lxdui/lxdui.service
    - user: root
    - group: root
    - require:
      - git: lxdui-clone

lxdui-systemd-reload:
  cmd.run:
    - name: 'systemctl daemon-reload'
    - onchanges:
      - file: /etc/systemd/system/lxdui.service

lxdui:
  service.running:
    - enable: True
    - require:
      - file: /etc/systemd/system/lxdui.service
