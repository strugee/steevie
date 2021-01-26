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

lxdui-clone:
  git.detached:
    - name: https://github.com/AdaptiveScale/lxdui.git
    - rev: v2.1.3
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
