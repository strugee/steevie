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

# We make no attempt to manage storage devices because those are highly system-specific
# TODO even specifying ashift may be too much.
rpool:
  zpool.present:
    - properties:
        ashift: '12'
        xattr: 'off'
        compression: 'on'
        feature@lz4_compress: enabled
        normalization: formD
        canmount: 'off'
        mountpoint: /
