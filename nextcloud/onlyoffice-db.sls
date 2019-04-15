include:
  - postgres

onlyoffice:
  postgres_user.present: []
  postgres_database.present: []

# TODO GRANT ALL to user on db
# TODO password for user
  
# TODO make Postgres listen on the LXD bridge
# TODO add the following line to /etc/postgresql/9.6/main/pg_hba.conf:
#host    onlyoffice,postgres      onlyoffice      onlyoffice.lxd          md5

# TODO make Redis listen on the LXD bridge
