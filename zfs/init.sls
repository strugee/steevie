{% for pkg in ['zfsutils-linux', 'zfs-dkms', 'zfs-initramfs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

zfs-zed:
  pkg.installed: []
  service.running:
    - require:
      - pkg: zfs-zed

/etc/udev/rules.d/10-zpool-io-elevator.rules:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://zfs/10-zpool-io-elevator.rules
