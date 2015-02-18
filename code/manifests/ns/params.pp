class lcgdm::ns::params (
) inherits lcgdm::base::params {

  $flavor           = "dpns"
  $host             = $fqdn
  $dbflavor         = "mysql"
  $dbhost           = "localhost"
  $dbmanage         = true
  $active           = "yes"
  $readonly         = "no"
  $disableautovids  = "no"
  $ulimitn          = hiera("lcgdm::ns::ulimitn", 65000)
  $coredump         = hiera("lcgdm::ns::coredump", "no")
  $numthreads       = hiera("lcgdm::ns::numthreads", 80)
  $configfile       = "/usr/etc/NSCONFIG"
  $logpermissions   = 0644

}
