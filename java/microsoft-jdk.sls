#ms_repo_pkg:
#  pkg.installed:
#    - sources:
#      - packages-microsoft-prod: https://packages.microsoft.com/config/debian/$(lsb_release -rs)

msopenjdk-21:
  pkg.installed
