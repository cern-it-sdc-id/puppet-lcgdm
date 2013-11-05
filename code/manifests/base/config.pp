class lcgdm::base::config (
    $user     = $lcgdm::base::params::user,
    $uid      = $lcgdm::base::params::uid,
    $gid      = $lcgdm::base::params::gid,
    $cert     = $lcgdm::base::params::cert,
    $certkey  = $lcgdm::base::params::certkey,
    $egiCA    = $lcgdm::base::params::egiCA
) inherits lcgdm::base::params {

  include('fetchcrl')

  group { $user:
      ensure => present,
      gid    => $gid,
  }

  user { $user:
      ensure     => present,
      uid        => $uid,
      gid        => $user,
      managehome => true,
      require    => Group[$user],
  }

  $grid_security_params = {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => 0755,
  }

  ensure_resource('file','/etc/grid-security', $grid_security_params)

  file {
    "/etc/grid-security/$user":
      ensure => directory,
      owner  => $user,
      group  => $user,
      mode   => 755,
      require => User[$user];
    "/etc/grid-security/$user/$cert":
      owner   => $user,
      group   => $user,
      mode    => 444,
      source  => "/etc/grid-security/hostcert.pem",
      require => User[$user];
    "/etc/grid-security/$user/$certkey":
      owner   => $user,
      group   => $user,
      mode    => 400,
      source  => "/etc/grid-security/hostkey.pem",
      require => User[$user];
    "/usr/share/augeas/lenses/dist/shift.aug":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 744,
      content => template("lcgdm/shift.aug");
  }

  augeas {"unlimit_${user}_nproc":
    context => "/files/etc/security/limits.d/90-nproc.conf",
    changes => [
      "set domain[. = '${user}'] ${user}",
      "set domain[. = '${user}']/type soft",
      "set domain[. = '${user}']/item nproc",
      "set domain[. = '${user}']/value unlimited"
    ]
  }

}

