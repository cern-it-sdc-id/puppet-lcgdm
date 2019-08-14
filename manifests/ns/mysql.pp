class lcgdm::ns::mysql ($flavor,$dbname,$dbuser, $dbpass, $dbhost) {
  # management of a mysql db (maybe this could be improved)
  include 'mysql::server'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql"
  } 

  # the packaged db script hardcode  the db name, we don't want that
  file_line { 'cns mysql commentuse':
    ensure => present,
    match  => 'USE cns_db.*',
    line   => '-- USE cns_db',
    path   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql"
  }

  mysql::db { $dbname:
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql",
    require  => File_line["${flavor} mysql commentcreate"],
    notify   => Class[lcgdm::ns::service]
  }

  if $dbhost != 'localhost'  and $dbhost != "${::fqdn}" {
        #create the database grants for the user
        mysql_grant { "${dbuser}@${::fqdn}/${dbname}.*":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => "${dbname}.*",
            require    => [Mysql_database["${dbname}"], Mysql_user["${dbuser}@${::fqdn}"], ],
            notify     => Class[lcgdm::ns::service]
        }
  }

}
