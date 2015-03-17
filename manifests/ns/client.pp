class lcgdm::ns::client (
  $flavor 	= undef,
  $dpmhost 	= $lcgdm::dpm::config::host
) {

  case $flavor {
    cns:     { $clientpkg = 'cns' }
    dpns:    { $clientpkg = 'dpm' }
    lfc:     { $clientpkg = 'lfc' }
    default: { $clientpkg = $lcgdm::ns::config::clientpkg }
  }

  package{$clientpkg: ensure => present }

}
