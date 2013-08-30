class lcgdm::ns::params (
) inherits lcgdm::base::params {

  $flavor  		= "dpns"
  $host    		= $fqdn
  $dbflavor		= "mysql"
  $dbuser  		= undef
  $dbpass  		= undef
  $dbhost  		= undef
  $dbmanage  		= false
  $active		= "yes"
  $readonly		= "no"
  $disableautovids	= "no"
  $ulimitn		= 4096
  $coredump		= "no"
  $numthreads		= 20

}
