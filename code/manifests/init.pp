class lcgdm (
  $dbuser,
  $dbpass,
  $domain,
  $volist,
  $flavor   = "dpns",
  $dbflavor = "mysql",
  $dbhost   = "localhost",
) {
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Dpm::Service]
  Class[Lcgdm::Ns::Service] -> Class[Lcgdm::Ns::Client]
  Class[Lcgdm::Dpm::Service] -> Lcgdm::Ns::Domain <| |>
  Lcgdm::Ns::Domain <| |> -> Lcgdm::Ns::Vo <| |>

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

  #
  # Create path for domain and VOs to be enabled.
  #
  lcgdm::ns::domain{"${domain}":}
  lcgdm::ns::vo{$volist:
    domain => "${domain}",
  }
}
