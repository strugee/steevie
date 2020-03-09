# TODO backport cockpit-pcp and pcp
{% for pkg in ['cockpit', 'cockpit-doc', 'sosreport'] %}
{{ pkg }}:
  pkg.installed

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
