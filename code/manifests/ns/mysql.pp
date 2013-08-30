class lcgdm::ns::mysql (
  $flavor,
  $dbuser,
  $dbpass,
  $dbhost
) {
  # management of a mysql db (maybe this could be improved)
  include 'mysql'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => "CREATE DATABASE.*",
    line   => "-- CREATE DATABASE.*",
    path   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql"
  }

  mysql::db{"cns_db":
    user	   => "${dbuser}",
    password => "${dbpass}",
    host	   => "${dbhost}",
    sql	   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql",
    require  => File_line["${flavor} mysql commentcreate"]
  }
}
