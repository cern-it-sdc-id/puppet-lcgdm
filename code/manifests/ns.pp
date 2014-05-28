class lcgdm::ns (
  $flavor          = $lcgdm::ns::params::flavor,
  $dbflavor        = $lcgdm::ns::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost          = $lcgdm::ns::params::dbhost,
  $dbmanage        = $lcgdm::ns::params::dbmanage,
  $coredump        = $lcgdm::ns::params::coredump,
  $uid             = undef,
) inherits lcgdm::ns::params {

  validate_bool($dbmanage)

  #
  # Base configuration
  #
  if !defined(Class["Lcgdm::Base"]) {
    class{"lcgdm::base":
      uid => $uid,
    }
  }

  class{"lcgdm::ns::config":
    flavor   => "${flavor}",
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    dbmanage => $dbmanage,
    coredump => "${coredump}",
  }
  class{"lcgdm::ns::install":}
  class{"lcgdm::ns::service":}
  class{"lcgdm::ns::client":
    flavor => "${flavor}"
  }
}
