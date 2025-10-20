php-fpm:
  pkg.installed

/etc/php/7.3/fpm/pool.d:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - source: salt://php/fpm-pool.d/

# TODO move /var/log/php7.3-fpm.log into this directory
/var/log/php-fpm:
  file.directory:
    - user: root
    - group: root
    - mode: 700

# TODO usermod -G redis -a www-data
