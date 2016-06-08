class lcgdm::base::config (
  $user    = $lcgdm::base::params::user,
  $uid     = $lcgdm::base::params::uid,
  $gid     = $lcgdm::base::params::gid,
  $cert    = $lcgdm::base::params::cert,
  $certkey = $lcgdm::base::params::certkey,
  $egiCA   = $lcgdm::base::params::egiCA) inherits lcgdm::base::params {
  include('fetchcrl')

  group { $user:
    ensure => present,
    gid    => $gid,
  }

  user { $user:
    ensure     => present,
    uid        => $uid,
    gid        => $gid,
    managehome => true,
    require    => Group[$user],
  }

  # define only if it doesn't exist,
  # no matter the parameters
  if !defined_with_params(File['/etc/grid-security'], '') {
    file { '/etc/grid-security':
      ensure  => directory,
      owner   => root,
      group   => root,
      mode    => '0755',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
    }
  }
  file {
    "/etc/grid-security/${user}":
      ensure  => directory,
      owner   => $user,
      group   => $user,
      mode    => '0755',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
      require => User[$user];

    "/etc/grid-security/${user}/${cert}":
      owner   => $user,
      group   => $user,
      mode    => '0444',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
      source  => '/etc/grid-security/hostcert.pem',
      require => User[$user];

    "/etc/grid-security/${user}/${certkey}":
      owner   => $user,
      group   => $user,
      mode    => '0400',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
      source  => '/etc/grid-security/hostkey.pem',
      require => User[$user];

    '/usr/share/augeas/lenses/dist/shift.aug':
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => '0744',
      seluser => 'system_u',
      selrole => 'object_r',
      seltype => 'etc_t',
      content => template('lcgdm/shift.aug');
  }
  #add notifications
  if defined ('lcgdm::dpm::service'){
	File["/etc/grid-security/${user}/${cert}"] ~> Class[lcgdm::dpm::service]
  }
  if defined ('lcgdm::ns::service') {
        File["/etc/grid-security/${user}/${cert}"] ~> Class[lcgdm::ns::service]	
  }
  if defined ('lcgdm::rfio::service') {
	File["/etc/grid-security/${user}/${cert}"] ~> Class[lcgdm::rfio::service]	
  }

  lcgdm::limits { 

	 "*-soft": domain => '*', type => 'soft', item => 'nofile', value =>  65000;
	 "*-hard": domain => '*', type => 'hard', item => 'nofile', value =>  65000;
	 "*-soft-nproc": domain => '*', type => 'soft', item => 'nproc', value =>  65000;
	 "*-hard-proc": domain => '*', type => 'hard', item => 'nproc', value =>  65000;
  }


}

