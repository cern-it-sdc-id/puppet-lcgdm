class lcgdm::ns::install (
) inherits lcgdm::ns::params {

    Class[Lcgdm::Ns::Config] -> Class[Lcgdm::Ns::Install]

    package { $lcgdm::ns::config::pkg: 
            ensure => present;
    }

    file {
      "/var/log/$lcgdm::ns::config::flavor":
        ensure  => directory,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 755;
      "/var/log/$lcgdm::ns::config::flavor/log":
        ensure  => present,
        owner   => $lcgdm::base::config::user,
        group   => $lcgdm::base::config::user,
        mode    => 600,
        require => File["/var/log/$lcgdm::ns::config::flavor"];
    }

    # management of a mysql db (maybe this could be improved)
    if $lcgdm::ns::config::dbmanage and $lcgdm::ns::config::dbflavor == "mysql" {
        include 'mysql'

        # the packaged db script explicitly creates the db, we don't want that
        file_line { "dpns mysql commentcreate":
          ensure => present,
          match  => "CREATE DATABASE.*",
          line   => "-- CREATE DATABASE.*",
          path   => "/usr/share/lcgdm/create_dpns_tables_mysql.sql",
          require=> Package[$lcgdm::ns::config::pkg]
        }
          
        mysql::db{"cns_db":
          user	   => "$lcgdm::ns::config::dbuser",
          password => "$lcgdm::ns::config::dbpass",
          host	   => "$lcgdm::ns::config::dbhost",
          sql	   => "/usr/share/lcgdm/create_dpns_tables_mysql.sql",
          require  => [ Class["mysql"], Package[$lcgdm::ns::config::pkg],
                        File_line["dpns mysql commentcreate"] ]
        }

    }
}
