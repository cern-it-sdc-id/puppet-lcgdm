class lcgdm::dpm::install () inherits lcgdm::dpm::params {
  Class[lcgdm::dpm::config] -> Class[lcgdm::dpm::install]

  package { "dpm-server-${lcgdm::dpm::config::dbflavor}": ensure => present; }

  file {
    '/var/log/dpm':
      ensure => directory,
      owner  => $lcgdm::base::config::user,
      group  => $lcgdm::base::config::user,
      mode   => '0755';

    '/var/log/dpm/log':
      ensure  => present,
      owner   => $lcgdm::base::config::user,
      group   => $lcgdm::base::config::user,
      mode    => '0644',
      require => File['/var/log/dpm'];
  }

  validate_bool($lcgdm::dpm::config::dbmanage)

  if $lcgdm::dpm::config::dbmanage and $lcgdm::dpm::config::dbflavor == 'mysql' {
    Class[lcgdm::dpm::mysql] -> Class[lcgdm::dpm::service]

    class { 'lcgdm::dpm::mysql':
      dbname  => $lcgdm::dpm::config::dpm_db,
      dbuser  => $lcgdm::dpm::config::dbuser,
      dbpass  => $lcgdm::dpm::config::dbpass,
      dbhost  => $lcgdm::dpm::config::dbhost,
      require => Package["dpm-server-${lcgdm::dpm::config::dbflavor}"]
    }

  }
}
