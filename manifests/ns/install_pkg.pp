class lcgdm::ns::install_pkg ($flavor, $dbflavor) {
  case $flavor {
    cns  : { $pkg = "cns-server-${dbflavor}" }
    dpns : { $pkg = "dpm-name-server-${dbflavor}" }
    lfc  : { $pkg = "lfc-server-${dbflavor}" }
  }

  package { $pkg: ensure => present; }
}
