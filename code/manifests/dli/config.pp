class lcgdm::dli::config (
  $active   	= $lcgdm::dli::params::active,
  $ulimitn  	= $lcgdm::dli::params::ulimitn,
  $lfchost    = $lcgdm::dli::params::lfchost
) inherits lcgdm::dli::params {

  Class[Lcgdm::Base::Config] -> Class[Lcgdm::Dli::Config]

  file {
    "/etc/sysconfig/lfc-dli":
      owner   => root,
      group   => root,
      mode    => 644,
      content => template("lcgdm/dli/sysconfig.erb");
  }

}
