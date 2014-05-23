class lcgdm::ns (
  $flavor          = $lcgdm::ns::params::flavor,
  $dbflavor        = $lcgdm::ns::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost          = $lcgdm::ns::params::dbhost,
  $dbmanage        = $lcgdm::ns::params::dbmanage,
  $coredump        = $lcgdm::ns::params::coredump,
  $staticuid       = false,
) inherits lcgdm::ns::params {
  if $staticuid {
    $dpmuid = 151
    $dpmgid = 151
  }
  class{"lcgdm::ns::config":
    flavor   => "${flavor}",
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    dbmanage => $dbmanage,
    coredump => "${coredump}",
    dpmuid   => $dpmuid,
    dpmgid   => $dpmgid,
  }
  class{"lcgdm::ns::install":}
  class{"lcgdm::ns::service":}
  class{"lcgdm::ns::client":
    flavor => "${flavor}"
  }
}
