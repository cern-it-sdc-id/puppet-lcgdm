class lcgdm::dli::config (
  $active  = $lcgdm::dli::params::active,
  $ulimitn = $lcgdm::dli::params::ulimitn,
  $lfchost = $lcgdm::dli::params::lfchost) inherits lcgdm::dli::params {
  Class[lcgdm::base::config] -> Class[lcgdm::dli::config]

  file { '/etc/sysconfig/lfc-dli':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('lcgdm/dli/sysconfig.erb');
  }

}
