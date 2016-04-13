class lcgdm::ns::mysql ($flavor, $dbuser, $dbpass, $dbhost) {
  # management of a mysql db (maybe this could be improved)
  include 'mysql::server'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql"
  }

  mysql::db { $lcgdm::ns::params::ns_db:
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql",
    require  => File_line["${flavor} mysql commentcreate"],
    notify   => Class[lcgdm::ns::service]
  }

  if $dbhost != 'localhost'  and $dbhost != "${::fqdn}" {
        #create the database grants for the user
        mysql_grant { "${dbuser}@${::fqdn}/${lcgdm::ns::params::ns_db}.*":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => "${lcgdm::ns::params::ns_db}.*'",
            require    => [Mysql_database["${lcgdm::ns::params::ns_db}"], Mysql_user["${dbuser}@${::fqdn}"], ],
            notify     => Class[lcgdm::ns::service]
        }
  }

}
