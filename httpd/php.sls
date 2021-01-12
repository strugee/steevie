php:
  pkg.installed

# For Nextcloud
# TODO ensure this is enabled
php-intl:
  pkg.installed

# Also installed for Nextcloud
php-imagick:
  pkg.installed

composer:
  pkg.installed

{% for context in ['apache2', 'cli'] %}

/etc/php/7.3/{{ context }}/conf.d/99-nextcloud-memory-limit.ini:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpd/99-nextcloud-memory-limit.ini

/etc/php/7.3/{{ context }}/conf.d/99-nextcloud-apcu-on-cli.ini:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpd/99-nextcloud-apcu-on-cli.ini

{% endfor %}
