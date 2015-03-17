class lcgdm::dpm::mysql ($dbuser, $dbpass, $dbhost) {
  include 'mysql'

  # the packaged db script explicitly creates the db, we don't want that
  file_line { 'dpm mysql commentcreate':
    ensure => present,
    match  => 'CREATE DATABASE.*',
    line   => '-- CREATE DATABASE.*',
    path   => '/usr/share/lcgdm/create_dpm_tables_mysql.sql'
  }

  mysql::db { 'dpm_db':
    user     => "${dbuser}",
    password => "${dbpass}",
    host     => "${dbhost}",
    sql      => '/usr/share/lcgdm/create_dpm_tables_mysql.sql',
    require  => File_line['dpm mysql commentcreate']
  }
}
