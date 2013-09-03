class lcgdm::ns::params (
) inherits lcgdm::base::params {

  $flavor  		= "dpns"
  $host    		= $fqdn
  $dbflavor		= "mysql"
  $dbhost  		= "localhost"
  $dbmanage  		= true
  $active		= "yes"
  $readonly		= "no"
  $disableautovids	= "no"
  $ulimitn		= 4096
  $coredump		= "no"
  $numthreads		= 20
  $configfile  = "/usr/etc/NSCONFIG"

}
