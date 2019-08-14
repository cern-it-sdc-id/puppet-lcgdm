class lcgdm::ns::install () inherits lcgdm::ns::params {
  Class[lcgdm::ns::config] -> Class[lcgdm::ns::install]

  package { $lcgdm::ns::config::pkg: ensure => present; }

  file {
    "/var/log/${lcgdm::ns::config::flavor}":
      ensure => directory,
      owner  => $lcgdm::base::config::user,
      group  => $lcgdm::base::config::user,
      mode   => $lcgdm::ns::config::logpermissions;

    "/var/log/${lcgdm::ns::config::flavor}/log":
      ensure  => present,
      owner   => $lcgdm::base::config::user,
      group   => $lcgdm::base::config::user,
      mode    => $lcgdm::ns::config::logpermissions,
      require => File["/var/log/${lcgdm::ns::config::flavor}"];
  }

  validate_bool($lcgdm::ns::config::dbmanage)

  if $lcgdm::ns::config::dbmanage and $lcgdm::ns::config::dbflavor == 'mysql' {
    Class[lcgdm::ns::mysql] -> Class[lcgdm::ns::service]

    class { 'lcgdm::ns::mysql':
      flavor  => $lcgdm::ns::config::flavor,
      dbname  => $lcgdm::ns::config::ns_db,
      dbuser  => $lcgdm::ns::config::dbuser,
      dbpass  => $lcgdm::ns::config::dbpass,
      dbhost  => $lcgdm::ns::config::dbhost,
      require => Package[$lcgdm::ns::config::pkg]
    }
  }

}
