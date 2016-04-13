class lcgdm::ns (
  $flavor   = $lcgdm::ns::params::flavor,
  $dbflavor = $lcgdm::ns::params::dbflavor,
  $dbuser,
  $dbpass,
  $dbhost   = $lcgdm::ns::params::dbhost,
  $ns_db    = $lcgdm::ns::params::ns_db,
  $dbmanage = $lcgdm::ns::params::dbmanage,
  $coredump = $lcgdm::ns::params::coredump,
  $uid      = undef,
  $gid      = undef,) inherits lcgdm::ns::params {
  validate_bool($dbmanage)

  #
  # Base configuration
  #
  if !defined(Class['lcgdm::base']) {
    class { 'lcgdm::base':
      uid => $uid,
      gid => $gid,
    }
  }

  class { 'lcgdm::ns::config':
    flavor   => "${flavor}",
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    ns_db    => "${ns_db}",
    dbmanage => $dbmanage,
    coredump => "${coredump}",
  }

  class { 'lcgdm::ns::install':
  }

  class { 'lcgdm::ns::service':
  }

  class { 'lcgdm::ns::client':
    flavor => "${flavor}"
  }
}
