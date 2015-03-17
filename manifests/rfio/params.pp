class lcgdm::rfio::params () inherits lcgdm::base::params {
  $active = 'yes'
  $ulimitn = 4096
  $coredump = 'no'
  $numthreads = 20
  $portrange = '20000 25000'
  $startoptions = '-sl'
  $nshost = $fqdn
  $dpmhost = $nshost

}
