# NodeSource repos are HTTPS

# In Debian 10 this transport is built-in to APT.
# TODO: remove this whole block and related requisites when all hosts are on Debian 10.
{% if grains['osmajorrelease'] == 9 %}
apt-transport-https:
  pkg.installed
{% endif %}

apt-listchanges:
  pkg.installed

gnupg:
  pkg.installed
