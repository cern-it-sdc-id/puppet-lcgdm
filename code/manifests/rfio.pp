class lcgdm::rfio (
  $dpmhost = "${::fqdn}",
  $nshost  = "${dpmhost}",
) {
  class{"lcgdm::rfio::config":
    dpmhost => "${dpmhost}",
    nshost  => "${nshost}",
  }
  class{"lcgdm::rfio::install":}
  class{"lcgdm::rfio::service":}
}
