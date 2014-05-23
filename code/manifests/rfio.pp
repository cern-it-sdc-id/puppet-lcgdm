class lcgdm::rfio (
  $dpmhost = "${::fqdn}",
  $nshost  = "${dpmhost}",
) {
  #include('lcgdm::base')

  class{"lcgdm::rfio::config":
    dpmhost => "${dpmhost}",
    nshost  => "${nshost}",
  }
  class{"lcgdm::rfio::install":}
  class{"lcgdm::rfio::service":}
}
