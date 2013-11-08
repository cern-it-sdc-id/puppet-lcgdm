class lcgdm (
  $dbuser,
  $dbpass,
  $flavor   = "dpns",
  $dbflavor = "mysql",
  $dbhost   = "localhost",
) {
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Dpm::Service]
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Ns::Client]

  #
  # Nameserver client and server configuration.
  #
  class{"lcgdm::ns":
    flavor   => "${flavor}",
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
  }

  #
  # DPM daemon configuration.
  #
  class{"lcgdm::dpm":
    dbflavor => "${dbflavor}",
    dbuser   => "${dbuser}",
    dbpass   => "${dbpass}",
    dbhost   => "${dbhost}",
  }
}
