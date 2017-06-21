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
  if versioncmp($::puppetversion, '4.0.0') < 0 {
    $lens_sel_type	= 'puppet_var_lib_t'
  }
  else {
    $lens_sel_type	= 'lib_t'
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

    [ "$puppet_vardir/lib", "$puppet_vardir/lib/augeas/", "$puppet_vardir/lib/augeas/lenses/" ]:
      ensure => directory;
    
    "$puppet_vardir/lib/augeas/lenses/shift.aug":
       ensure  => present,
       owner   => root,
       group   => root,
       mode    => '0744',
       seluser => 'system_u',
       selrole => 'object_r',
       seltype => $lens_sel_type,
       content => template('lcgdm/shift.aug');
  }

  lcgdm::limits { 

	 "*-soft": domain => '*', type => 'soft', item => 'nofile', value =>  65000;
	 "*-hard": domain => '*', type => 'hard', item => 'nofile', value =>  65000;
	 "*-soft-nproc": domain => '*', type => 'soft', item => 'nproc', value =>  65000;
	 "*-hard-proc": domain => '*', type => 'hard', item => 'nproc', value =>  65000;
  }


}

