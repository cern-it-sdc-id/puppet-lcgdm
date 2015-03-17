class lcgdm::shift::config () {
  file { '/etc/shift.conf':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
  }

}
