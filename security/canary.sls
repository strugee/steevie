# Remove old GCC versions because it makes canaries more annoying if we have to divert 3x the number of binaries

gcc-6:
  pkg.removed

gcc-6-base:
  pkg.removed

{% macro arm_binary(path, bin_desc) -%}
dpkg-divert-{{ path }}:
  cmd.run:
    - name: 'dpkg-divert --local --divert {{ path }}.nocanary --rename --add {{ path }}'
    - creates: {{ path }}.nocanary
    - unless: test -e {{ path }}.nocanary

{{ path }}:
  file.managed:
    - source: salt:///security/canary.sh
    - mode: 755
    - template: jinja
    - defaults:
      bin_desc: {{ bin_desc }}
    - require:
      - cmd: dpkg-divert-{{ path }}
{%- endmacro %}

{{ arm_binary('/usr/bin/x86_64-linux-gnu-gcc-8', 'GCC') }}
{{ arm_binary('/usr/bin/x86_64-linux-gnu-g++-8', 'G++') }}
{{ arm_binary('/bin/nc.openbsd', 'nc(1)') }}
{{ arm_binary('/bin/nc.traditional', 'nc(1)') }}
