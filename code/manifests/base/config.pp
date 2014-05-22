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

  exec {"create_lcgdm_user":
    command     => "/usr/sbin/useradd ${user} -u ${uid} -g ${gid}",
    environment => "PATH=/sbin:/bin:/usr/sbin:/usr/bin",
    unless      => "/usr/bin/id -u ${user}"
  }
  # this is complicated and fails, when the user already
  # exists with another UID. puppet tries to recreate
  # the user then, which would probably result in a
  # mess. don't know if files that the user owned would
  # get converted and it fails if the user is logged in.
  #user { $user:
  #    ensure     => present,
  #    uid        => $uid,
  #    gid        => $gid,
  #    managehome => true,
  #    require    => Group[$user],
  #}

  # define only if it doesn't exist,
  # no matter the parameters
  if ! defined_with_params(File['/etc/grid-security'], '') {
    file {
      '/etc/grid-security':
        ensure  => directory,
        owner   => root,
        group   => root,
        mode    => 0755,
        seluser => "system_u",
        selrole => "object_r",
        seltype => "etc_t",
    }
  }

  file {
    "/etc/grid-security/$user":
      ensure   => directory,
      owner    => $user,
      group    => $user,
      mode     => 755,
      seluser  => "system_u",
      selrole  => "object_r",
      seltype  => "etc_t",
      #require => User[$user];
      require  => Exec["create_lcgdm_user"];
    "/etc/grid-security/$user/$cert":
      owner   => $user,
      group   => $user,
      mode    => 444,
      seluser => "system_u",
      selrole => "object_r",
      seltype => "etc_t",
      source  => "/etc/grid-security/hostcert.pem",
      #require => User[$user];
      require  => Exec["create_lcgdm_user"];
    "/etc/grid-security/$user/$certkey":
      owner   => $user,
      group   => $user,
      mode    => 400,
      seluser => "system_u",
      selrole => "object_r",
      seltype => "etc_t",
      source  => "/etc/grid-security/hostkey.pem",
      #require => User[$user];
      require  => Exec["create_lcgdm_user"];
    "/usr/share/augeas/lenses/dist/shift.aug":
      ensure  => present,
      owner   => root,
      group   => root,
      mode    => 744,
      seluser => "system_u",
      selrole => "object_r",
      seltype => "etc_t",
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

