https://github.com/davisking/dlib.git:
  git.detached:
    - rev: v19.19
    - target: /usr/local/src/dlib
#    - require:
#      - pkg: git

cmake:
  pkg.installed

libmkldnn-dev:
  pkg.installed

libx11-dev:
  pkg.installed

dlib-build:
  cmd.run:
    - name: "chown -R nobody . && sudo -u nobody sh -c 'mkdir -p build && cd build && cmake -DBUILD_SHARED_LIBS=ON .. && make'; chown -R root ."
    - cwd: /usr/local/src/dlib/dlib
    - creates: build/libdlib.so.19.19.0
    - require:
      - git: https://github.com/davisking/dlib.git
      - pkg: cmake
      - pkg: libmkldnn-dev

'make install':
  cmd.run:
    - cwd: /usr/local/src/dlib/dlib/build
    - creates: /usr/local/lib/libdlib.so.19.19.0
    - require:
      - cmd: dlib-build

php7.3-dev:
  pkg.installed

https://github.com/goodspb/pdlib.git:
  git.detached:
    - rev: v1.0
    - target: /usr/local/src/pdlib
    - require:
      - pkg: php7.3-dev
#      - pkg: git

pdlib-clean:
  cmd.run:
    - name: git clean -dfx
    - cwd: /usr/local/src/pdlib
    - onchanges:
      - git: pdlib

'phpize':
  cmd.run:
    - creates: configure
    - cwd: /usr/local/src/pdlib
    - require:
      - git: pdlib

'./configure --prefix=/usr/local --enable-debug':
  cmd.run:
    - cwd: /usr/local/src/pdlib
    - creates: config.h
    - require:
      - cmd: phpize

pdlib-make:
  cmd.run:
    - name: 'chown -R nobody . && sudo -u nobody make && chown -R root .'
    - cwd: /usr/local/src/pdlib
#    - creates: config.h
# TODO requres

# XXX TODO XXX VERY BAD THIS PUTS FILES IN /usr NOT /usr/local!!!!!
# TODO make this run if stuff has changed...
make-install-pdlib:
  cmd.run:
    - name: make install
    - cwd: /usr/local/src/pdlib
    - creates: /usr/lib/php/20180731/pdlib.so
    - require:
      - cmd: pdlib-make

/etc/php/7.3/mods-available/pdlib.ini:
  file.managed:
    - source: salt://nextcloud/pdlib.ini

'phpenmod pdlib':
  cmd.run:
    - creates: /etc/php/7.3/apache2/conf.d/20-pdlib.ini
    - requires:
      - file: /etc/php/7.3/mods-available/pdlib.ini

