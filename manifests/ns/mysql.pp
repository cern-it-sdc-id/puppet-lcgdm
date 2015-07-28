class lcgdm::ns::mysql ($flavor, $dbuser, $dbpass, $dbhost) {
  # management of a mysql db (maybe this could be improved)
  include 'mysql'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { "${flavor} mysql commentcreate":
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql"
  }

  mysql::db { 'cns_db':
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => "/usr/share/lcgdm/create_${flavor}_tables_mysql.sql",
    require  => File_line["${flavor} mysql commentcreate"],
    notify   => Class[Lcgdm::Ns::Service]
  }

  if $dbhost != 'localhost' {
        #create the database grants for the user
        mysql_grant { "${dbuser}@${::fqdn}/'cns_db.*'":
            ensure     => 'present',
            options    => ['GRANT'],
            privileges => ['ALL'],
            provider   => 'mysql',
            user       => "${dbuser}@${::fqdn}",
            table      => 'cns_db.*',
            require    => [Mysql_database['cns_db'], Mysql_user["${dbuser}@${::fqdn}"], ],
            notify     => Class[Lcgdm::Ns::Service]
        }
  }

}
