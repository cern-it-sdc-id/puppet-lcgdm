class lcgdm::dpm (
  $dbflavor        = $lcgdm::dpm::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost          = $lcgdm::dpm::params::dbhost,
  $dbmanage        = $lcgdm::dpm::params::dbmanage,
  $coredump        = $lcgdm::ns::params::coredump,
  $staticuid       = false,
) inherits lcgdm::dpm::params {
  if $staticuid {
    $dpmuid = 151
    $dpmgid = 151
  } else {
    $dpmuid = undef
    $dpmgid = undef
  }
  class{"lcgdm::dpm::config":
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    dbmanage => $dbmanage,
    coredump => "${coredump}",
    dpmuid   => $dpmuid,
    dpmgid   => $dpmgid,
  }
  class{"lcgdm::dpm::install":}
  class{"lcgdm::dpm::service":}
}
