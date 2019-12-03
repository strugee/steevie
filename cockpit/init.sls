# TODO backport cockpit-pcp and pcp
{% for pkg in ['cockpit', 'cockpit-doc', 'sosreport'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% if grains['osmajorrelease'] > 10 %}
cockpit-pcp:
  pkg.installed
{% endif %}

