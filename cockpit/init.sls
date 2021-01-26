# TODO backport cockpit-pcp and pcp
{% for pkg in ['cockpit', 'cockpit-doc', 'sosreport'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% if grains['osmajorrelease'] > 10 %}
cockpit-pcp:
  pkg.installed
{% endif %}

{% for pkg in ['modemmanager', 'dnsmasq-base', 'ppp'] %}
{{ pkg }}:
  pkg.removed:
    - require:
      - pkg: cockpit
{% endfor %}

wpa_supplicant:
  service.masked

wpa_supplicant_dead:
  service.dead:
    - name: wpa_supplicant
    - enable: False

# TODO Cockpit motd
