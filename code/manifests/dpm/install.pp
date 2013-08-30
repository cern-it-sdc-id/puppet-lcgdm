class lcgdm::dpm::install (
) inherits lcgdm::dpm::params {

    Class[Lcgdm::Dpm::Config] -> Class[Lcgdm::Dpm::Install]

    package { "dpm-server-${lcgdm::dpm::config::dbflavor}": 
            ensure => present;
    }

    file {
      "/var/log/dpm":
        ensure  => directory,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 755;
      "/var/log/dpm/log":
        ensure  => present,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 600,
        require => File["/var/log/dpm"];
    }

    # management of a mysql db (maybe this could be improved)
    if $lcgdm::dpm::config::dbmanage and $lcgdm::dpm::config::dbflavor == "mysql" {
        include 'mysql'

        # the packaged db script explicitly creates the db, we don't want that
        file_line { "dpm mysql commentcreate":
          ensure => present,
          match  => "CREATE DATABASE.*",
          line   => "-- CREATE DATABASE.*",
          path   => "/usr/share/lcgdm/create_dpm_tables_mysql.sql",
          require=> Package["dpm-server-${lcgdm::dpm::config::dbflavor}"]
        }

        mysql::db{"dpm_db":
          user	   => "$lcgdm::dpm::config::dbuser",
          password => "$lcgdm::dpm::config::dbpass",
          host	   => "$lcgdm::dpm::config::dbhost",
          sql	   => "/usr/share/lcgdm/create_dpm_tables_mysql.sql",
          require  => [ Class["mysql"], Package["dpm-server-${lcgdm::dpm::config::dbflavor}"],
                        File_line["dpm mysql commentcreate"] ]
        }

    }
}
