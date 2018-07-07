# TODO apt-mark auto

{% for pkg in ['git', 'git-doc', 'git-svn', 'subversion', 'mercurial'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

