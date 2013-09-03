
class lcgdm::xrootd (
  $nodetype = ["head", "disk", "fed"], # head, disk, and fed(eration)
  $domain,
  $xrootd_use_voms = true,
  $xrootd_disk_use_voms = false,
  $dpm_xrootd_debug = false,
  $dpm_xrootd_sharedkey = undef,
  $dpm_xrdserverport = 1095,
  $xrd_dpmclassic = false,
  $site_name = undef,
  $alice_token = false,
  $alice_token_conf = undef,
  $alice_token_libname = undef,
  $alice_token_principal = undef,
  $alice_fqans = undef
  #$dpm_xrootd_fedredirs
) {
  package {"dpm-xrootd":
    ensure => present
  }

  $domainpath = "/${lcgdm::ns::config::basepath}/$domain"

  include xrootd::config

  $sec_protocol_local = "/usr/${xrootd::config::xrdlibdir} unix"

  if member($nodetype, "disk") {

    if $xrootd_disk_use_voms {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/\${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_disk = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    if $xrd_dpmclassic == false {
      $ofs_tpc = "pgm /usr/bin/xrdcp --server"
    }

    $xrootd_instances_options_disk = { 
      "disk" => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmdisk.cfg" 
    }

    lcgdm::xrootd::create_config{"/etc/xrootd/xrootd-dpmdisk.cfg":
      all_adminpath => "/var/spool/xrootd",
      all_pidpath   => "/var/run/xrootd",
      all_sitename  => $site_name,
      xrd_allrole   => "server",
      xrootd_seclib => "libXrdSec.so",
      xrootd_export => [ "/" ],
      xrootd_async  => "off",
      ofs_authlib   => "libXrdDPMDiskAcc.so.3",
      ofs_authorize => true,
      xrd_ofsosslib => "libXrdDPMOss.so.3",
      ofs_persist   => "auto hold 0",
      xrd_port      => 1095,
      xrd_network   => "nodnr",
      xrd_debug     => $dpm_xrootd_debug,
      ofs_tpc       => $ofs_tpc,
      sec_protocol  => [ $sec_protocol_disk, $sec_protocol_local ]
    }
  } else {
    $xrootd_instances_options_disk = {}
  }

  if member($nodetype, "head") {

    if $xrootd_disk_use_voms {

      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsfun:/usr/\${xrootd::config::xrdlibdir}/libXrdSecgsiVOMS.so"
    } else {
      $sec_protocol_redir = "/usr/${xrootd::config::xrdlibdir} gsi -crl:3 -key:/etc/grid-security/${lcgdm::base::config::user}/dpmkey.pem -cert:/etc/grid-security/${lcgdm::base::config::user}/dpmcert.pem -md:sha256:sha1 -ca:2 -gmapopt:10 -vomsat:0"
    }

    $xrootd_instances_options_redir = {
      "redir" => "-l /var/log/xrootd/xrootd.log -c /etc/xrootd/xrootd-dpmredir.cfg"
    }

    if $xrd_dpmclassic == false {
      $dpm_listvoms = true
    }

    if $alice_token == false {
      $ofs_authlib = "libXrdDPMRedirAcc.so.3"
    }

    lcgdm::xrootd::create_config{"/etc/xrootd/xrootd-dpmredir.cfg":
      all_adminpath         => "/var/spool/xrootd",
      all_pidpath           => "/var/run/xrootd",
      all_sitename          => $site_name,
      xrd_allrole           => "manager",
      xrootd_seclib         => "libXrdSec.so",
      xrootd_export         => [ "/" ],
      ofs_authlib           => $ofs_authlib,
      ofs_authorize         => true,
      xrd_ofsosslib         => "libXrdDPMOss.so.3",
      ofs_cmslib            => "libXrdDPMFinder.so.3",
      ofs_forward           => "all",
      xrd_network           => "nodnr",
      xrd_debug             => $dpm_xrootd_debug,
      sec_protocol          => [ $sec_protocol_redir, $sec_protocol_local ],
      dpm_listvoms          => $dpm_listvoms,
      dpm_defaultprefix     => "${domainpath}/home",
      dpm_xrdserverport     => $dpm_xrdserverport,
      domainpath            => $domainpath,
      alice_token           => $alice_token,
      alice_token_conf      => $alice_token_conf,
      alice_token_principal => $alice_token_principal,
      alice_token_libname   => $alice_token_libname,
      alice_fqans           => $alice_fqans
    }
  } else {
    $xrootd_instances_options_redir = {}
  }

  if member($nodetype, "fed") {
    $xrootd_instances_options_fed = {}

  } else {
    $xrootd_instances_options_fed = {}
  }

  $xrootd_instances_options_all = merge(
    $xrootd_instances_options_disk,
    $xrootd_instances_options_redir,
    $xrootd_instances_options_fed
  )

  $exports = { "DPM_HOST"             => $lcgdm::dpm::config::host,
               "DPNS_HOST"            => $lcgdm::ns::config::host,
               "DPM_CONRETRY"         => 0,
               "DPNS_CONRETRY"        => 0,
               "XRD_MAXREDIRECTCOUNT" => 1
  }

  if $dpm_xrootd_debug {
    $daemon_corefile_limit = "unlimited"
  }

  xrootd::create_sysconfig{$xrootd::config::sysconfigfile:
    xrootd_user              => $lcgdm::base::config::user,
    xrootd_group             => $lcgdm::base::config::user,
    xrootd_instances_options => $xrootd_instances_options_all,
    exports                  => $exports,
    daemon_corefile_limit    => $daemon_corefile_limit
  }

  # TODO: make the basedir point to $xrootd::config::configdir
  file{"/etc/xrootd/dpmxrd-sharedkey.dat":
    ensure  => file,
    owner   => $lcgdm::base::config::user,
    group   => $lcgdm::base::config::user,
    mode    => 0640,
    content => $dpm_xrootd_sharedkey
  }


  include xrootd::install
  include xrootd::service
}
