# TODO backport cockpit-pcp and pcp
{% for pkg in ['cockpit', 'cockpit-doc', 'sosreport'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
