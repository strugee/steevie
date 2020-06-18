{% for pkg in ['roundcube', 'roundcube-plugins', 'roundcube-plugins-extra', 'roundcube-mysql'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
