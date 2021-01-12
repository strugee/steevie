php-fpm:
  pkg.installed

/etc/php/7.3/fpm/pool.d:
  file.recurse:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - source: salt://php/fpm-pool.d/
