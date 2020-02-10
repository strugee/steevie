php7.0:
  pkg.installed

# For Nextcloud
# TODO ensure this is enabled
php7.0-intl:
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
