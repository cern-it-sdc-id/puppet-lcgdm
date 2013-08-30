class lcgdm::ns::client (
  $flavor = "dpns"
) {

  case $flavor {
    cns: { $clientpkg = "cns" }
    dpns:{ $clientpkg = "dpm" }
    lfc: { $clientpkg = "lfc" }
  }

  package{$lcgdm::ns::config::clientpkg: ensure => present }

}
