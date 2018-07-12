{% for pkg in ['zfsutils-linux', 'zfs-dkms', 'zfs-initramfs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

zfs-zed:
  pkg.installed: []
  service.running:
    - require:
      - pkg: zfs-zed
