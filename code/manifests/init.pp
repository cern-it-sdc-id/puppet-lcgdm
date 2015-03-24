class lcgdm (
  $dbuser,
  $dbpass,
  $domain,
  $volist,
  $flavor   = 'dpns',
  $dbflavor = 'mysql',
  $dbhost   = 'localhost',
  $coredump = 'no',
  $dbmanage = true,
  $uid      = undef,
  $gid      = undef,) {
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Dpm::Service]
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Ns::Client]
  Class[Lcgdm::Dpm::Service] -> Lcgdm::Ns::Domain <| |>
  Lcgdm::Ns::Domain <| |> -> Lcgdm::Ns::Vo <| |>

  validate_bool($dbmanage)

  #
  # Base configuration
  #
  if !defined(Class['Lcgdm::Base']) {
    if gid != undef {
      class { 'lcgdm::base':
        uid => $uid,
        gid => $gid,
      }
    } else {
      class { 'lcgdm::base':
        uid => $uid,
        gid => $uid,
      }
    }

  }

  #
  # Nameserver client and server configuration.
  #
  if gid != undef {
    class { 'lcgdm::ns':
      flavor   => "${flavor}",
      dbflavor => "${dbflavor}",
      dbuser   => "${dbuser}",
      dbpass   => "${dbpass}",
      dbhost   => "${dbhost}",
      coredump => "${coredump}",
      dbmanage => $dbmanage,
      uid      => $uid,
      gid      => $gid,
    }
  } else {
    class { 'lcgdm::ns':
      flavor   => "${flavor}",
      dbflavor => "${dbflavor}",
      dbuser   => "${dbuser}",
      dbpass   => "${dbpass}",
      dbhost   => "${dbhost}",
      coredump => "${coredump}",
      dbmanage => $dbmanage,
      uid      => $uid,
      gid      => $uid,
    }
  }

  #
  # DPM daemon configuration.
  #
  class { 'lcgdm::dpm':
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
    coredump => "${coredump}",
    dbmanage => $dbmanage,
  }

  #
  # Create path for domain and VOs to be enabled.
  #
  validate_array($volist)

  lcgdm::ns::domain { "${domain}": }

  lcgdm::ns::vo { $volist: domain => "${domain}", }
}
