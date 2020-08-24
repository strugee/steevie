# Remove old GCC versions because it makes canaries more annoying if we have to divert 3x the number of binaries

gcc-6:
  pkg.removed

gcc-6-base:
  pkg.removed


# TODO:
# dpkg-divert --local --divert /usr/bin/x86_64-linux-gnu-gcc-8.nocanary --rename --add /usr/bin/x86_64-linux-gnu-gcc-8
