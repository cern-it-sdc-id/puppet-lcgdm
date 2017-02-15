class lcgdm::dpm (
  $dbflavor = $lcgdm::dpm::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost   = $lcgdm::dpm::params::dbhost,
  $dpm_db   = $lcgdm::dpm::params::dpm_db,
  $dbmanage = $lcgdm::dpm::params::dbmanage,
  $coredump = $lcgdm::ns::params::coredump) inherits lcgdm::dpm::params {
  class { 'lcgdm::dpm::config':
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    dpm_db   => "${dpm_db}",
    dbmanage => $dbmanage,
    coredump => "${coredump}",
  }

  class { 'lcgdm::dpm::install':
  }

  class { 'lcgdm::dpm::service':
  }
}
