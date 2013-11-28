class lcgdm::ns (
  $flavor          = $lcgdm::ns::params::flavor,
  $dbflavor        = $lcgdm::ns::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost          = $lcgdm::ns::params::dbhost,
  $dbmanage        = $lcgdm::ns::params::dbmanage,
) inherits lcgdm::ns::params {
  class{"lcgdm::ns::config":
    flavor   => "${flavor}",
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    dbmanage => $dbmanage,
  }
  class{"lcgdm::ns::install":}
  class{"lcgdm::ns::service":}
  class{"lcgdm::ns::client":
    flavor => "${flavor}"
  }
}
