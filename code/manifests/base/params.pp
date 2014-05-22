class lcgdm::base::params {
    $libdir = $architecture ? {
      "x86_64" => "lib64",
      default  => "lib",
    }

    $user     = "dpmmgr"
    $cert     = "dpmcert.pem"
    $certkey  = "dpmkey.pem"
    $uid      = 151
    $gid      = 151

    $egiCA    = true
}
