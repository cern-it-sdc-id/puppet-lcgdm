class lcgdm::dpm::params (
) inherits lcgdm::base::params {

  $host			= $fqdn
  $nshost		= $host
  $dbflavor		= "mysql"
  $dbuser  		= undef
  $dbpass  		= undef
  $dbhost  		= undef
  $dbmanage  		= false
  $active		= "yes"
  $ulimitn		= 4096
  $coredump		= "no"
  $numfthreads		= 20
  $numsthreads		= 20
  $syncget		= "no"

}
