debian-security-support:
  pkg.installed

debsecan:
  debconf.set:
    - data:
        debsecan/suite: { type: 'select', value: '{{ grains['oscodename'] }}' }
        debsecan/source: { type: 'string', value: '' }
        debsecan/mailto: { type: 'string', value: 'root' }
        debsecan/report: { type: 'boolean', value: 'true' }
  pkg.installed:
    - require:
      - debconf: debsecan

# TODO check out pkg Recommends and fine-tune
# TODO this installs Tripwire which requires interactive installation (for now)
# TODO ensure logcheck is removed cause it's so spammy
#checksecurity:
#  pkg.installed

