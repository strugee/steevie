php:
  pkg.installed

# For Nextcloud
# TODO ensure this is enabled
php-intl:
  pkg.installed

# Also installed for Nextcloud
php-imagick:
  pkg.installed

/etc/php/7.3/apache2/conf.d/99-nextcloud-memory-limit.ini:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpd/99-nextcloud-memory-limit.ini

/etc/php/7.3/cli/conf.d/99-nextcloud-memory-limit.ini:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpd/99-nextcloud-memory-limit.ini
