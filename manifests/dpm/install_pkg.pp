class lcgdm::dpm::install_pkg ($dbflavor) {
  package { "dpm-server-${dbflavor}": ensure => present; }
}
