class lcgdm::dpm::params (
) inherits lcgdm::base::params {

  $host			= $fqdn
  $nshost		= $host
  $dbflavor		= "mysql"
  $dbhost  		= "localhost"
  $dbmanage  		= true
  $active		= "yes"
  $ulimitn		= 4096
  $coredump		= "no"
  $numfthreads		= 20
  $numsthreads		= 20
  $syncget		= "yes"
  $configfile = "/usr/etc/DPMCONFIG"
  $reqcleantimeout = "3m"

}
